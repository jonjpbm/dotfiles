function tib_to_tb {
    local TiB=$1
    local TB=$(echo "scale=12; $TiB * 1024^4 / 1000^4" | bc)
    echo $TB
}


getsshpod() {
    HOST=$1
    if [ -z "$HOST" ]; then
        echo "You must specify a node name."
        exit 1
    fi

    sshTest=$(kubectl get pods -l name=ssh-test 2>&1)
    if [ "$sshTest" != "No resources found in default namespace." ]; then
        echo $(kubectl get pods -l name=ssh-test -o custom-columns=":metadata.name",":spec.nodeName" | grep -w "${HOST}" | awk '{ print $1 }')
    else
        echo $(kubectl get pods -l name=ssh -o custom-columns=":metadata.name",":spec.nodeName" | grep -w "${HOST}" | awk '{ print $1 }')
    fi
}

kenter() {
    HOST=$1
    ssh_pod=$(getsshpod "${HOST}")
    kubectl exec -it "${ssh_pod}" -- nsenter -t 1 -m -u -i -n -p -- /bin/bash
}

from_epoch() {
    date -j -f %s "$1"
}

grep_alias() {
    alias | grep "$1"
}

# Convert decimal to binary
function decimal2binary () {
    echo "obase=2;$1" | bc
}

# Export AWS Profile
function ExportAWSProfile () {
    export AWS_PROFILE=${1}
}

# Unset AWS Profile
function UnsetAWSProfile () {
    unset AWS_PROFILE
}

# UTC Conversion
function to_utc () {
    if [ -z "${1}" ];then
        date -u "+%a %b %d %H:%M:%S %Z %z"
        TZ=":US/Eastern" date "+%a %b %d %H:%M:%S %Z %z"
        TZ=":US/Central" date "+%a %b %d %H:%M:%S %Z %z"
        TZ=":US/Mountain" date "+%a %b %d %H:%M:%S %Z %z"
        TZ=":US/Arizona" date "+%a %b %d %H:%M:%S %Z %z"
        TZ=":US/Pacific" date "+%a %b %d %H:%M:%S %Z %z"
        TZ=":US/Alaska" date "+%a %b %d %H:%M:%S %Z %z"
        TZ=":US/Hawaii" date "+%a %b %d %H:%M:%S %Z %z"
        unset TZ
    else
        gdate --date="TZ=\":US/Central\" ${1}" -u "+%a %b %d %H:%M:%S %Z %z"
    fi
}

# Convert utc time passed to now
# NOTE: b/c this is on mac, I used coreutils tool gdate and NOT
# the mac native date command
function from_utc () {
    gdate --date="TZ=\"UTC\" ${1}"
}

# Replaces spaces with dashes
function space_to_dash()
{
    # Check if a single string parameter is provided
    if [ $# -ne 1 ]; then
        echo "Usage: $0 <string>"
        exit 1
    fi

    # Replace spaces with dashes using parameter expansion
    result="${1// /-}"

    echo "$result"
}

function create_work_dir ()
{
    # Get the parameter
    dir_name=$( space_to_dash "$1")

    # Set the Documents directory path
    docs_dir=~/Documents

    # Create the new directory
    mkdir -v -p "$docs_dir/$dir_name"
}

# https://github.com/ahmetb/kubectl-aliases
function kubectl() { echo "+ kubectl $@">&2; command kubectl $@; }
