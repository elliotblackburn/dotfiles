# Decode and display JWT tokens locally
# Usage: jwt <jwt_token>
# Requires: jq (install via: brew install jq)
jwt() {
    if (( $+commands[jq] )); then
        jq -R 'split(".") | .[0],.[1] | @base64d | fromjson' <<< "${1}"
        echo "Signature: $(echo "${1}" | awk -F'.' '{print $3}')"
    fi
}
