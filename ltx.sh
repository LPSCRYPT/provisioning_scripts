#!/bin/bash

source /venv/main/bin/activate
COMFYUI_DIR=${WORKSPACE}/ComfyUI

# Packages are installed after nodes so we can fix them...

APT_PACKAGES=(
    #"package-1"
    #"package-2"
)

PIP_PACKAGES=(
    #"package-1"
    #"package-2"
)

NODES=(
    #"https://github.com/ltdrdata/ComfyUI-Manager"
    #"https://github.com/cubiq/ComfyUI_essentials"
    "https://github.com/kijai/ComfyUI-KJNodes"
    "https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite"
    "https://github.com/Fannovel16/ComfyUI-Frame-Interpolation"
    "https://github.com/city96/ComfyUI-GGUF"
    "https://github.com/pollockjj/ComfyUI-MultiGPU"
    "https://github.com/asagi4/ComfyUI-Adaptive-Guidance"
    #
    "https://github.com/pythongosssss/ComfyUI-Custom-Scripts"
    "https://github.com/kijai/ComfyUI-Florence2"
    "https://github.com/calcuis/gguf"
    "https://github.com/Lightricks/ComfyUI-LTXVideo"
    "https://github.com/WASasquatch/was-node-suite-comfyui"
    "https://github.com/crystian/ComfyUI-Crystools"
    "https://github.com/giriss/comfy-image-saver"
    "https://github.com/M1kep/ComfyLiterals"
    "https://github.com/DoctorDiffusion/ComfyUI-MediaMixer"
)

WORKFLOWS=(

)

CHECKPOINT_MODELS=(
    "https://huggingface.co/Lightricks/LTX-Video/resolve/main/ltxv-13b-0.9.7-distilled-fp8.safetensors"
)

UNET_MODELS=(
)

LORA_MODELS=(
    # "https://civitai.com/api/download/models/1794316"
    # "https://civitai.com/api/download/models/782610" # cyber UI
    # "https://civitai.com/api/download/models/1726033" # YFG Cinema 4D Abstract
    # "https://civitai.com/api/download/models/1691109" # YFG Acrylic
    # "https://civitai.com/api/download/models/1430848" # Parametric Design
    # "https://civitai.com/api/download/models/772866" # WildStyle Text
    # "https://civitai.com/api/download/models/1193686" # OpticalIllusion
    # "https://civitai.com/api/download/models/1588418?" # Basquiat
    # "https://civitai.com/api/download/models/1346178" # Synthesia
    # "https://civitai.com/api/download/models/865988" # Gerard Richter
    # "https://civitai.com/api/download/models/1726070" # 3D Studio Max
    # "https://civitai.com/api/download/models/802867" # Everyday 3D Render
    # "https://civitai.com/api/download/models/996914" # ascii
    # "https://civitai.com/api/download/models/819856" # vaporwave
    # "https://civitai.com/api/download/models/997381" # breakcore
    # "https://civitai.com/api/download/models/962716" # mechanical insects
    # "https://civitai.com/api/download/models/814781" # digital human
    # "https://civitai.com/api/download/models/927943" # text poster
    # "https://civitai.com/api/download/models/776600" # johnny mnemonic
    # "https://civitai.com/api/download/models/771546" # stained glass
    # "https://civitai.com/api/download/models/832651" # action figure in box
    # "https://civitai.com/api/download/models/806561" # digital glitch
    # "https://civitai.com/api/download/models/753803" # zen ink wash sumi-e
    # "https://civitai.com/api/download/models/762800" # surreal photorealism
    # "https://civitai.com/api/download/models/752643" # pizel style
    # "https://civitai.com/api/download/models/771424" # dystopian realism
    # "https://civitai.com/api/download/models/752866" # junji ito
    # "https://civitai.com/api/download/models/800571" # retro glitch
)

VAE_MODELS=(
    "https://huggingface.co/calcuis/ltxv0.9.6-gguf/resolve/main/pig_video_enhanced_vae_fp32-f16.gguf"
)

ESRGAN_MODELS=(
)

CONTROLNET_MODELS=(
)

DIFFUSION_MODELS=(
    "https://huggingface.co/wsbagnsv1/ltxv-13b-0.9.7-distilled-GGUF/resolve/main/ltxv-13b-0.9.7-distilled-Q8_0.gguf"
    "https://huggingface.co/wsbagnsv1/ltxv-13b-0.9.7-dev-GGUF/resolve/main/ltxv-13b-0.9.7-dev-Q8_0.gguf"
)

CLIP_VISION=(
    # "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/clip_vision/clip_vision_h.safetensors"
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors"
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp16.safetensors"
)

TEXT_ENCODERS=(
    # "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp16.safetensors"
    # "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors"
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp16.safetensors"
    "https://huggingface.co/calcuis/ltxv0.9.6-gguf/resolve/main/t5xxl_fp32-q4_0.gguf"
)


### DO NOT EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING ###

function provisioning_start() {

    provisioning_print_header
    provisioning_get_apt_packages
    provisioning_get_nodes
    provisioning_get_pip_packages

    Get licensed models if HF_TOKEN set & valid
    if provisioning_has_valid_hf_token; then
        UNET_MODELS+=("https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/flux1-dev.safetensors")
        VAE_MODELS+=("https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/ae.safetensors")
    else
        UNET_MODELS+=("https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/flux1-schnell.safetensors")
        VAE_MODELS+=("https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/ae.safetensors")
        sed -i 's/flux1-dev\.safetensors/flux1-schnell.safetensors/g' /opt/ComfyUI/web/scripts/defaultGraph.js
    fi

    provisioning_get_files \
        "${COMFYUI_DIR}/models/checkpoints" \
        "${CHECKPOINT_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/unet" \
        "${UNET_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/lora" \
        "${LORA_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/controlnet" \
        "${CONTROLNET_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/vae" \
        "${VAE_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/esrgan" \
        "${ESRGAN_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/diffusion_models" \
        "${DIFFUSION_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/text_encoders" \
        "${TEXT_ENCODERS[@]}" 
    provisioning_get_files \
        "${COMFYUI_DIR}/models/clip_vision" \
        "${CLIP_VISION[@]}"   
    provisioning_print_end

}

function provisioning_get_apt_packages() {
    if [[ -n $APT_PACKAGES ]]; then
            sudo $APT_INSTALL ${APT_PACKAGES[@]}
    fi
}

function provisioning_get_pip_packages() {
    if [[ -n $PIP_PACKAGES ]]; then
            pip install --no-cache-dir ${PIP_PACKAGES[@]}
    fi
}

function provisioning_get_nodes() {
    for repo in "${NODES[@]}"; do
        dir="${repo##*/}"
        path="${COMFYUI_DIR}/custom_nodes/${dir}"
        requirements="${path}/requirements.txt"
        if [[ -d $path ]]; then
            if [[ ${AUTO_UPDATE,,} != "false" ]]; then
                printf "Updating node: %s...\n" "${repo}"
                ( cd "$path" && git pull )
                if [[ -e $requirements ]]; then
                   pip install --no-cache-dir -r "$requirements"
                fi
            fi
        else
            printf "Downloading node: %s...\n" "${repo}"
            git clone "${repo}" "${path}" --recursive
            if [[ -e $requirements ]]; then
                pip install --no-cache-dir -r "${requirements}"
            fi
        fi
    done
}

function provisioning_get_files() {
    if [[ -z $2 ]]; then return 1; fi
    
    dir="$1"
    mkdir -p "$dir"
    shift
    arr=("$@")
    printf "Downloading %s model(s) to %s...\n" "${#arr[@]}" "$dir"
    for url in "${arr[@]}"; do
        printf "Downloading: %s\n" "${url}"
        provisioning_download "${url}" "${dir}"
        printf "\n"
    done
}

function provisioning_print_header() {
    printf "\n##############################################\n#                                            #\n#          Provisioning container            #\n#                                            #\n#         This will take some time           #\n#                                            #\n# Your container will be ready on completion #\n#                                            #\n##############################################\n\n"
}

function provisioning_print_end() {
    printf "\nProvisioning complete:  Application will start now\n\n"
}

function provisioning_has_valid_hf_token() {
    [[ -n "$HF_TOKEN" ]] || return 1
    url="https://huggingface.co/api/whoami-v2"

    response=$(curl -o /dev/null -s -w "%{http_code}" -X GET "$url" \
        -H "Authorization: Bearer $HF_TOKEN" \
        -H "Content-Type: application/json")

    # Check if the token is valid
    if [ "$response" -eq 200 ]; then
        return 0
    else
        return 1
    fi
}

function provisioning_has_valid_civitai_token() {
    [[ -n "$CIVITAI_TOKEN" ]] || return 1
    url="https://civitai.com/api/v1/models?hidden=1&limit=1"

    response=$(curl -o /dev/null -s -w "%{http_code}" -X GET "$url" \
        -H "Authorization: Bearer $CIVITAI_TOKEN" \
        -H "Content-Type: application/json")

    # Check if the token is valid
    if [ "$response" -eq 200 ]; then
        return 0
    else
        return 1
    fi
}

# Download from $1 URL to $2 file path
function provisioning_download() {
    if [[ -n $HF_TOKEN && $1 =~ ^https://([a-zA-Z0-9_-]+\.)?huggingface\.co(/|$|\?) ]]; then
        auth_token="$HF_TOKEN"
    elif 
        [[ -n $CIVITAI_TOKEN && $1 =~ ^https://([a-zA-Z0-9_-]+\.)?civitai\.com(/|$|\?) ]]; then
        auth_token="$CIVITAI_TOKEN"
    fi
    if [[ -n $auth_token ]];then
        wget --header="Authorization: Bearer $auth_token" -qnc --content-disposition --show-progress -e dotbytes="${3:-4M}" -P "$2" "$1"
    else
        wget -qnc --content-disposition --show-progress -e dotbytes="${3:-4M}" -P "$2" "$1"
    fi
}

# Allow user to disable provisioning if they started with a script they didn't want
if [[ ! -f /.noprovisioning ]]; then
    provisioning_start
fi
