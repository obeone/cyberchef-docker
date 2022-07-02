#!/usr/bin/env bash
set -ex

# Default values
app_name=cyberchef
repository=harbor.obeone.cloud/public/cyberchef
base_build_tag=base_build
git_repo=https://api.github.com/repos/gchq/CyberChef/tags

platform="linux/amd64,linux/arm64,linux/i386,linux/armhf,linux/armel"
version="$(curl -s $git_repo | jq -r '.[0].name')"
tag="$version"
pull=0
publish_latest=0
create_builder=0
builder_name=

print_help () {
    cat <<EOF

Build a multi-arch image and publish it

Options :
    -h          This help
    -r string   Repository name (Default : ${repository})
    -t string   Tag name (Default : ${tag})
    -b string   Docker buildx builder name
    -p string   Platform list (Default : ${platform})
    -v string   Version number (checkout git. Default : ${version})
    -l          Publish a "lastest" tag in addition to -t
    -c          Create (and delete) a new builder
    -P          Pull previous builds

Example :
  $0 -r foo/$(basename "$(pwd)") -t 1.0.0 -l

EOF
}

while getopts "b:p:r:t:lcPhv" flag
do
    case "${flag}" in
        r) repository="${OPTARG}";;
        t) tag="${OPTARG}";;
        l) publish_latest=1;;
        p) platform="${OPTARG}";;
        b) builder_name="${OPTARG}";;
        c) create_builder=1;;
        P) pull=1;;
        v) version="${OPTARG}";;
        *) print_help; exit;;
    esac
done

echo -e "\e[34mBuilding ${app_name}…\e[0m"
docker buildx build --push -t "${repository}:${base_build_tag}" --build-arg GIT_TAG="$version" -f Dockerfile.build . || exit 1

if [ $create_builder ]; then
    echo -e "\e[34mCreating builder…\e[0m"
    builder_name=$(docker buildx create --name "${builder_name}")
fi

args=()

args+=(--push)
args+=(--platform "${platform}")
args+=(--build-arg base_image="${repository}:${base_build_tag}")
args+=(-t "${repository}:${tag}")

if [ -e "$builder_name" ]; then
    args+=(--builder "${builder_name}")
fi

if [ $publish_latest ]; then
    args+=(-t "${repository}:latest")
fi

if [ $pull ]; then
    args+=(--pull)
fi

echo -e "\e[34mBuilding…\e[0m"
docker buildx build "${args[@]}" .

if [ $create_builder ]; then
    echo -e "\e[34mCreating builder…\e[0m"
    docker buildx rm "${builder_name}"
fi