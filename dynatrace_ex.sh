#!/bin/sh

readonly AGENT_SHORT_NAME="Dynatrace"
readonly BRANDING_PRODUCTSHORTNAME="OneAgent"
readonly AGENT_PRODUCT_NAME="${AGENT_SHORT_NAME} ${BRANDING_PRODUCTSHORTNAME}"
readonly BRANDING_PRODUCTNAME_LOWER="dynatrace"
readonly BRANDING_PRODUCTSHORTNAME_LOWER="oneagent"

readonly SELINUXPOLICY_BASEFILENAME=${BRANDING_PRODUCTNAME_LOWER}_${BRANDING_PRODUCTSHORTNAME_LOWER}
readonly SELINUXPOLICY_BASE_COMPILE_VERSION=24
readonly SELINUXPOLICY_FILENAME_DEFAULT=${SELINUXPOLICY_BASEFILENAME}_${SELINUXPOLICY_BASE_COMPILE_VERSION}
readonly SELINUXPOLICY_FILENAME_VERSION_31=${SELINUXPOLICY_BASEFILENAME}_31

readonly AGENT_BIN=${BRANDING_PRODUCTSHORTNAME_LOWER}os
readonly AGENT_WATCHDOG=${BRANDING_PRODUCTSHORTNAME_LOWER}watchdog
readonly AGENT_LOG_ANALYTICS=${BRANDING_PRODUCTSHORTNAME_LOWER}loganalytics
readonly AGENT_NETWORK=${BRANDING_PRODUCTSHORTNAME_LOWER}network
readonly AGENT_PLUGIN=${BRANDING_PRODUCTSHORTNAME_LOWER}plugin
readonly AGENT_PROC=${BRANDING_PRODUCTSHORTNAME_LOWER}proc
readonly AGENT_HELPER=${BRANDING_PRODUCTSHORTNAME_LOWER}helper
readonly AGENT_OS_HELPER=${BRANDING_PRODUCTSHORTNAME_LOWER}oshelper
readonly AGENT_UTIL_BIN=${BRANDING_PRODUCTSHORTNAME_LOWER}util
readonly AGENT_OS_CONFIG_BIN=${BRANDING_PRODUCTSHORTNAME_LOWER}osconfig
readonly DUMP_PROC_BIN=${BRANDING_PRODUCTSHORTNAME_LOWER}dumpproc
readonly AGENT_PROC_LIB=lib${AGENT_PROC}.so
readonly AGENT_LOADER_LIB=lib${BRANDING_PRODUCTSHORTNAME_LOWER}loader.so

readonly INITDFILE=${BRANDING_PRODUCTSHORTNAME_LOWER}

readonly PA_RECOVERY_SCRIPT=${BRANDING_PRODUCTSHORTNAME_LOWER}proc
readonly PA_RECOVERY_MOUNT_POINT=/etc/${BRANDING_PRODUCTSHORTNAME_LOWER}proc
readonly PA_RECOVERY_TMPFS_SIZE=256k

readonly SYSTEMD_UNIT_FILE_AGENT=${INITDFILE}.service
readonly SYSTEMD_UNIT_FILE_AGENT_PROC=${PA_RECOVERY_SCRIPT}.service

readonly INSTALL_FOLDER=${BRANDING_PRODUCTNAME_LOWER}/${BRANDING_PRODUCTSHORTNAME_LOWER}
readonly INSTALL_BASE=/opt
readonly INSTALL_PATH=${INSTALL_BASE}/${INSTALL_FOLDER}
readonly AGENT_INSTALL_PATH=${INSTALL_PATH}/agent
readonly PARTIAL_INSTALL_PATH=${INSTALL_BASE}/${BRANDING_PRODUCTNAME_LOWER}

readonly LOG_PATH=${INSTALL_PATH}/log
readonly AGENTCONF_PATH=${AGENT_INSTALL_PATH}/conf
readonly WATCHDOG_INI_FILE_NAME=ruxitwatchdog.ini
readonly PA_STARTUP_FLAG_FILE=${AGENT_INSTALL_PATH}/conf/ruxitagentprocflag.conf
readonly PA_FALLBACK_INSTALLATION_PATH="${AGENT_INSTALL_PATH}/processagent"
readonly AGENT_STATE_FILE_PATH=${AGENT_INSTALL_PATH}/agent.state

readonly HOOKING_STATUS_FILE=${AGENTCONF_PATH}/hookingStatus
readonly SYSTEM_LIB_DIRS_FILE=${AGENTCONF_PATH}/systemLibDirs
readonly HOOKING_STATUS_UNKNOWN=0
readonly HOOKING_STATUS_ENABLED=1
readonly HOOKING_STATUS_DISABLED_PARAM=2
readonly HOOKING_STATUS_DISABLED_SANITY=4
readonly HOOKING_STATUS_DISABLED_RECOVERY_SCRIPT=5

readonly RUNTIME_BASE=/var/lib
readonly RUNTIME_DIR=${RUNTIME_BASE}/${BRANDING_PRODUCTNAME_LOWER}/${BRANDING_PRODUCTSHORTNAME_LOWER}
readonly PARTIAL_RUNTIME_DIR=${RUNTIME_BASE}/${BRANDING_PRODUCTNAME_LOWER}
readonly AGENT_RUNTIME_DIR=${RUNTIME_DIR}/agent
readonly AGENT_RUNTIME_CONF_PATH=${AGENT_RUNTIME_DIR}/config
readonly AGENT_CONF_FILE_NAME=ruxitagent.conf
readonly LOG_ANALYTICS_CONF_FILE_NAME=ruxitagentloganalytics.conf
readonly WATCHDOG_RUNTIME_CONF_FILE_NAME=watchdogruntime.conf
readonly AGENT_PROC_RUNTIME_CONF_FILE_NAME=ruxitagentproc.conf
readonly HOST_ID_FILE_NAME=ruxithost.id
readonly WATCHDOG_USER_CONF_FILE_NAME=watchdoguserconfig.conf
readonly HOST_AUTOTAG_CONF_FILE_NAME=hostautotag.conf
readonly INFRAONLY_CONF_FILE=${AGENT_RUNTIME_CONF_PATH}/infraonly.conf
readonly INSTALLATION_CONF_FILE_NAME="installation.conf"

readonly CORE_PATTERN_PATH="/proc/sys/kernel/core_pattern"
readonly BACKUP_CORE_PATTERN_PATH="${AGENT_INSTALL_PATH}/.original_core_pattern"
readonly BACKUP_SYSCTL_CORE_PATTERN_ENTRY_PATH="${AGENT_INSTALL_PATH}/.original.sysctl.corepattern"
readonly BACKUP_UBUNTU_APPORT_CONFIG="${AGENT_INSTALL_PATH}/.backup_apport_config"
readonly UBUNTU_APPORT_CONFIG_PATH="/etc/default/apport"
readonly REDHAT_ABRT_SCRIPT_PATH="/etc/init.d/abrt-ccpp"
readonly SYSCTL_PATH="/etc/sysctl.conf"
readonly SYSCTL_CORE_PATTERN_OPTION="kernel.core_pattern"

readonly UNINSTALL_INFO_FILE_PATH="${AGENTCONF_PATH}/uninstall.info"
readonly CONTAINER_DEPLOYMENT_CONF_FILE="${AGENTCONF_PATH}/dockerdeployment.conf"

INIT_SYSTEM=
INIT_FOLDER=
readonly INIT_SYSTEM_SYSV="SysV"
readonly INIT_SYSTEM_SYSTEMD="systemd"
readonly SYSTEMD_UNIT_FILES_FOLDER="/etc/systemd/system/"
readonly AGENT_INIT_SCRIPTS_FOLDER="${AGENT_INSTALL_PATH}/initscripts"

readonly DOWNLOADS_DIRECTORY="${INSTALL_PATH}/downloads"

readonly INSTALLATION_LOG_DIR=${LOG_PATH}/installer
#LOG_FILE overriden in shellinstall.sh
LOG_FILE=${INSTALLATION_LOG_DIR}/installation.log

readonly EXIT_CODE_OK=0
readonly EXIT_CODE_GENERIC_ERROR=1
readonly EXIT_CODE_SANITY_CRASHING=3
readonly EXIT_CODE_SANITY_HOOKING=4
readonly EXIT_CODE_CANNOT_PRESERVE_CONFIGURATION=5
readonly EXIT_CODE_NOT_ENOUGH_SPACE=6
readonly EXIT_CODE_NOT_ENOUGH_MEMORY=7
readonly EXIT_CODE_INVALID_PARAM=8
readonly EXIT_CODE_INSUFFICIENT_PERMISSIONS=9
readonly EXIT_CODE_SEMANAGE_NOT_FOUND=10
readonly EXIT_CODE_WATCHDOG_ALREADY_RUNNING=11
readonly EXIT_CODE_SIGNAL_RECEIVED=12
readonly EXIT_CODE_ANOTHER_INSTALLER_RUNNING=13
readonly EXIT_CODE_AGENT_CONTAINER_RUNNING=14
readonly EXIT_CODE_GLIBC_VERSION_TOO_LOW=15
readonly EXIT_CODE_PACKAGE_IS_CORRUPTED=16
readonly EXIT_CODE_REQUIRED_COMMAND_NOT_AVAILABLE=17

################################################################################
#       Logs
################################################################################
toLog() {
        if [ -w "${LOG_FILE}" ]; then
                echo "$(date -u +"%Y-%m-%d %H:%M:%S") UTC" "$@" >> ${LOG_FILE}
        fi
}

toConsoleOnly() {
        echo "$(date +"%H:%M:%S")" "$@"
}

toLogInfo() {
        toLog "[INFO]" "$@"
}

toLogWarning() {
        toLog "[WARN]" "$@"
}

toLogError() {
        toLog "[ERROR]" "$@"
}

toLogAdaptive() {
        local success="${1}"
        shift
        if [ "${success}" -eq 0 ]; then
                toLogInfo "$@"
        else
                toLogError "$@"
        fi
}

toConsoleInfo() {
        toConsoleOnly "$@"
        toLogInfo "$@"
}

toConsoleWarning() {
        toConsoleOnly "Warning:" "$@"
        toLogWarning "$@"
}

toConsoleError() {
        toConsoleOnly "Error:" "$@"
        toLogError "$@"
}

createDirIfNotExistAndSetRights() {
        local dir="${1}"
        local rights="${2}"
        if [ ! -d "${dir}" ]; then
                if ! mkdir -p "${dir}"; then
                        toConsoleWarning "Cannot create ${dir} directory."
                fi
        fi

        if ! chmod "${rights}" "${dir}"; then
                toConsoleWarning "Cannot change permisions of ${dir} directory to ${rights}."
        fi
}

createLogDirsIfMissing() {
        createDirIfNotExistAndSetRights "${INSTALL_BASE}" u+rwx,g+rx,o+rx
        createDirIfNotExistAndSetRights "${PARTIAL_INSTALL_PATH}" u+rwx,g+rx,o+rx
        createDirIfNotExistAndSetRights "${INSTALL_PATH}" 755
        createDirIfNotExistAndSetRights "${INSTALL_PATH}/log" 1777
        createDirIfNotExistAndSetRights "${INSTALL_PATH}/log/process" 1777
        for logDir in "installer" "os" "network" "plugin" "loganalytics"; do
                createDirIfNotExistAndSetRights "${INSTALL_PATH}/log/${logDir}" 775
        done

        touch ${LOG_FILE}
}


################################################################################
#       Platform characteristics detection
################################################################################

detectLinuxDistribution() {  
        if [ -f /etc/redhat-release ]; then
                cat /etc/redhat-release
        elif [ -f /etc/os-release ]; then
                (. /etc/os-release
                        local distrib="${NAME}"
                        if [ -z "${distrib}" ]; then
                                distrib="${ID}"
                        fi

                        local version="${VERSION_ID}"
                        if echo "${distrib}" | grep -iq "debian"; then
                                version="$(cat /etc/debian_version)"
                        fi

                        printf "%s %s" "${distrib}" "${version}"
                )
        elif [ -f /etc/SuSE-release ]; then
                head -1 /etc/SuSE-release
        elif [ -f /etc/lsb-release ]; then
                (. /etc/lsb-release; 
                        printf "%s %s" "${DISTRIB_ID}" "${DISTRIB_RELEASE}"
                )
        elif ls /etc/*release* > /dev/null 2>&1; then 
                # Generic fallback
                cat /etc/*release*
        else
                printf "AIX %s" "$(oslevel -s)"
        fi
}

checkInitSystem() {
        local output=
        output="$(systemctl --version 2>&1)"
        if [ $? -eq 0 ]; then
                toLogInfo "${INIT_SYSTEM_SYSTEMD} version: ${output}"

                if [ -d "${SYSTEMD_UNIT_FILES_FOLDER}" ]; then
                        INIT_SYSTEM=${INIT_SYSTEM_SYSTEMD}
                else
                        INIT_SYSTEM=${INIT_SYSTEM_SYSV}
                        toLogWarning "${INIT_SYSTEM_SYSTEMD} was detected but ${SYSTEMD_UNIT_FILES_FOLDER} does not exist, using ${INIT_SYSTEM_SYSV} handling as a fallback"
                fi
        else
                INIT_SYSTEM=${INIT_SYSTEM_SYSV}
        fi

        toLogInfo "Detected init system: ${INIT_SYSTEM}"
}

setLocationOfInitScripts() {
        toLogInfo "Determining location of init scripts..."

        if [ "${INIT_SYSTEM}" = ${INIT_SYSTEM_SYSTEMD} ]; then
                INIT_FOLDER=${AGENT_INIT_SCRIPTS_FOLDER}
        else
                if [ -d /etc/init.d ]; then
                        INIT_FOLDER=/etc/init.d
                elif [ -d /sbin/init.d ]; then
                        INIT_FOLDER=/sbin/init.d
                elif [ -d /etc/rc.d ]; then
                        INIT_FOLDER=/etc/rc.d
                else
                        return 1
                fi
        fi

        toLogInfo "Location of init scripts ${INIT_FOLDER}"
        return 0
}

detectArchitecture() {
        local detected_arch=
        if isAvailable arch; then
                detected_arch="$(arch | tr '[:lower:]' '[:upper:]')"
        fi

        if [ -z "${detected_arch}" ]; then
                detected_arch="$(uname -m | tr '[:lower:]' '[:upper:]')"
        fi

        printf '%s' "${detected_arch}"
}

################################################################################
#       Misc functions
################################################################################

getAgentUtilBinPath() {
        local binFolder="$(arch_getBinariesFolder)"
        printf "%s" "${AGENT_INSTALL_PATH}/tools/${binFolder}/${AGENT_UTIL_BIN}"
}

getOsConfigBinPath() {
        local binFolder="$(arch_getBinariesFolder)"
        printf "%s" "${AGENT_INSTALL_PATH}/tools/${binFolder}/${AGENT_OS_CONFIG_BIN}"
}

changeProcessAgentState() {
        local action="${1}"
        toLogInfo "Process agent action: ${action}..."
        local changeStatus=
        changeStatus=$("$(getAgentUtilBinPath)" "${action}procagent" 2>&1)
        toLogAdaptive $? "Process agent ${action} status: ${changeStatus}"
}

commandErrorWrapper() {
        local command="${*}"
        local errorFile="/tmp/oneagent_commanderror_$$"
        ${command} 2>"${errorFile}"
        local returnCode=$?

        if [ ${returnCode} -ne 0 ]; then
                toLogWarning "$(cat "${errorFile}")"
        fi

        rm -f "${errorFile}"

        return ${returnCode}
}

getWatchdogPid() {
        ps -ef | grep "${AGENT_WATCHDOG}.*${AGENT_BIN}" | grep -v "grep" | grep -v "sudo" | awk '{{ print $2 }}'
}

isNamespaceIsolated() {
        local pid="${1}"
        local namespace="${2}"
        local initNamespaceId="$(readlink "/proc/1/ns/${namespace}" 2>/dev/null | tr -dc '0-9')"
        local processNamespaceId="$(readlink "/proc/${pid}/ns/${namespace}" 2>/dev/null | tr -dc '0-9')"

        if [ ! "${initNamespaceId}" ] || [ ! "${processNamespaceId}" ]; then
                toLogInfo "Link to /proc/*/ns/${namespace} does not exist"
                printf 'error'
                return
        fi

        if [ "${initNamespaceId}" != "${processNamespaceId}" ]; then
                printf 'true'
        else
                printf 'false'
        fi
}

isProcessRunningInContainer() {
        if [ "${ARCH_ARCH}" = "AIX" ]; then
                return 1
        fi

        local pid="${1}"
        [ "$(isNamespaceIsolated "${pid}" mnt)" = "true" ]
}

isDeployedViaContainer() {
        grep -q "DeployedInsideDockerContainer=true" "${CONTAINER_DEPLOYMENT_CONF_FILE}" 2>/dev/null
}

checkRootAccess() {
        toConsoleInfo "Checking root privileges..."

        local MY_UID="$(id -u)"
        if [ "${MY_UID}" != "0" ]; then
                toConsoleError "NOT OK"
                return 1
        fi

        toConsoleInfo "OK"
        return 0
}

removeIfExists() {
        local fileToRemove="${1}"
        if [ -e "${fileToRemove}" ]; then
                rm -rf "${fileToRemove}"
        else
                toLogInfo "Not removing: ${fileToRemove}, file does not exist"
        fi
}

################################################################################
#       SELinux related functions
################################################################################
cleanUpOldPolicies() {
        local basePolicyName="${SELINUXPOLICY_BASEFILENAME}"
        local installedPolicyName="$(semodule -l 2>/dev/null | grep "${basePolicyName}" | awk '{ print $1 }')"

        if [ -n "${installedPolicyName}" ]; then
                toLogInfo "Removing base module"
                local errorMessage
                errorMessage="$(semodule -r "${installedPolicyName}" 2>&1)"
                if [ $? -ne 0 ] ; then
                        toConsoleError "Failed to remove ${installedPolicyName} module."
                        toLogError "[semodule error]: ${errorMessage}"
                else
                        toConsoleInfo "Removed ${installedPolicyName} module."
                fi
        fi
}

restoreSELinuxContext() {
        local file="${1}"
        if [ ! -e "${file}" ]; then
                return
        fi

        if ! isAvailable restorecon; then 
                return
        fi

        toLogInfo "Restoring default SELinux security context for ${file}"
        if ! restorecon -R "${file}" >/dev/null 2>&1; then
                toLogWarning "Failed to restore default SELinux security context for ${file}"
        fi
}

removeContextsForCustomInstallationPath() {
        local installDir="$(readLink -f "${INSTALL_PATH}")"
        if [ "${installDir}" = "${INSTALL_PATH}" ]; then
                return
        fi

        toLogInfo "Removing security contexts for ${installDir}"

        local contexts="$(semanage fcontext --list -C | grep ${BRANDING_PRODUCTSHORTNAME_LOWER} | awk '{print $1}')"
        for c in ${contexts}; do
                toLogInfo "Removing ${c}"
                semanage fcontext -d "${c}" >>${LOG_FILE} 2>&1
        done
}

executeUsingOsConfigBin() {
        local command="${1}"
        local unit="${2}"
        if [ "${unit}" ]; then
                command="${command}-${unit}"
                unit=""
        fi

        local output=
        output="$("$(getOsConfigBinPath)" "${command}" 2>&1)"
        local exitCode=$?
        toLogAdaptive ${exitCode} "Executed $(getOsConfigBinPath) ${command} ${unit}, exitCode = ${exitCode}, output: ${output}"
        return ${exitCode}
}

executeSystemctlCommand() {
        local command="${1}"
        local unit="${2}"

        if [ "$(id -u)" != 0 ]; then
                executeUsingOsConfigBin "${command}" "${unit}"
                return $?
        fi

        local output=
        #shellcheck disable=SC2086
        output="$(systemctl "${command}" ${unit} 2>&1)"
        local exitCode=$?

        if [ ${exitCode} -eq 0 ]; then
                toLogInfo "Successfully executed: systemctl ${command} ${unit}"
        else
                toLogError "Failed to execute: systemctl ${command} ${unit}"
                toLogError "Command output: ${output}"
                if [ -n "${unit}" ]; then
                        local reachBackNumSeconds=360
                        toLogError "journalctl output: $(journalctl -u "${unit}" --since=-${reachBackNumSeconds} 2>&1)"
                fi
        fi

        return ${exitCode}
} 2>>${LOG_FILE}

executeInitScriptCommand() {
        local initScript="${INIT_FOLDER}/${INITDFILE}"
        local command="$*"
        local output=
        local exitCode=
        #shellcheck disable=SC2086
        output="$("${initScript}" ${command} 2>&1)"
        exitCode=$?
        toLogAdaptive ${exitCode} "Executed ${initScript} ${command}, exitCode = ${exitCode}, output: ${output}"
        return ${exitCode}
}

signalHandler() {
        local signal="${1}"
        local callback="${2}"
        toLogWarning "process received signal: ${signal}"
        ${callback}
        exit ${EXIT_CODE_SIGNAL_RECEIVED} 
}

configureSignalHandling() {
        local callback="${1}"
        for signal in HUP INT QUIT ABRT ALRM TERM; do
                #shellcheck disable=SC2064
                trap "signalHandler ${signal} ${callback}" ${signal}
        done
}

removeSecretsFromString() {
        printf "%s" "$*" | sed 's#\(Api-Token=\)[[:alnum:]_-]\{21\}#\1***#' | 
                sed 's#\(TENANT_TOKEN=\)[[:alnum:]]\{16\}#\1***#' |
                sed 's#\(latest/\)[[:alnum:]]\{16\}#\1***#' |
                sed 's#\(PROXY=\)[^[:space:]]*#\1***#'
}

setLdSoPreloadPermissions() {
        local preloadFileLocation="${1}"
        restoreSELinuxContext "${preloadFileLocation}"
        commandErrorWrapper chmod 644 "${preloadFileLocation}"
}

checkIfWatchdogWithPidExists() {
        local pattern="${1}"
        local pid="$(getWatchdogPid | grep "${pattern}")"
        if [ -z "${pid}" ]; then
                pid="0"
        fi
        printf "%s" "${pid}"
}

# waitTime must be divisible by 10
sendSignalToProcessAndWaitForStop() {
        local pidCheckingFunction="${1}"
        local signal="${2}"
        local action="${3}"
        local waitTime="${4}"
        local pid="${5}"

        local pidToStop="$(${pidCheckingFunction} "${pid}")"
        if [ "${pidToStop}" -eq "0" ]; then
                toLogInfo "Process with pid ${pid} doesn't exist"
                return
        fi

        toConsoleInfo "Waiting ${waitTime} seconds for process with pid ${pidToStop} to ${action}."
        while [ "${waitTime}" -gt 0 ]; do
                if [ "$((waitTime % 10))" -eq 0 ]; then
                        toLogInfo "Sending signal: ${signal} to ${pidToStop}"
                        kill -s "${signal}" "${pidToStop}" 2>/dev/null
                fi

                pidToStop="$(${pidCheckingFunction} "${pidToStop}")"
                if [ "${pidToStop}" -eq "0" ]; then
                        return 0
                fi
                sleep 1
                waitTime=$((waitTime-1))
        done

        return 1
}

stopWatchdog() {
        local signal="${1}"
        local watchdogPid="$(getWatchdogPid)"
        if [ -z "${watchdogPid}" ]; then
                toLogInfo "No watchdogs running."
                return
        fi

        local watchdogPidToStop
        for watchdogPidToStop in ${watchdogPid}; do
                toConsoleInfo "Stopping ${AGENT_PRODUCT_NAME}. Watchdog pid: ${watchdogPidToStop}."
                sendSignalToProcessAndWaitForStop "checkIfWatchdogWithPidExists" "${signal}" "stop" 90 "${watchdogPidToStop}"
                if [ $? -eq 1 ]; then
                        toConsoleWarning "Watchdog is still running. Killing watchdog process ${watchdogPidToStop}."
                        sendSignalToProcessAndWaitForStop "checkIfWatchdogWithPidExists" "9" "be killed" 10 "${watchdogPidToStop}"
                else
                        toConsoleInfo "Watchdog process ${watchdogPidToStop} stopped."
                fi
        done
}

testWriteAccessToDir() {
        local errorFile="/tmp/oneagent_commandError_$$"
        local dir="${1}"
        local tmpfilename
        if [ "${ARCH_ARCH}" = "AIX" ]; then
                tmpfilename="${dir}/.tmp_${BRANDING_PRODUCTSHORTNAME_LOWER}.$$${RANDOM}"
                touch "${tmpfilename}" 2>"${errorFile}"
        else
                tmpfilename="$(mktemp -p "${dir}" ".tmp_${BRANDING_PRODUCTSHORTNAME_LOWER}.XXXXXXXXXXXXXX" 2>"${errorFile}")"
        fi

        if [ $? -ne 0 ]; then
                toLogInfo "$(cat "${errorFile}")"
                rm -f "${errorFile}"
                return 1
        fi

        rm -f "${tmpfilename}" "${errorFile}"
        return 0
}

setPATH() {
        local prependToPATH="/usr/sbin:/usr/bin:/sbin:/bin"
        if [ "${PATH}" ]; then
                PATH=${prependToPATH}:${PATH}
        else
                PATH=${prependToPATH}
        fi
}

systemLibDirSanityCheck() {
        local dir="${1}"
        if [ ! -d "${dir}" ]; then
                toLogWarning "Directory: ${dir} does not exist"
                printf ""
                return
        fi

        if ! testWriteAccessToDir "${dir}"; then
                toLogWarning "Detected that ${dir} is not writable"
                dir="${PA_FALLBACK_INSTALLATION_PATH}${dir}"
                createDirIfNotExistAndSetRights "${dir}" 755
        fi

        printf "%s" "${dir}"
}

isNonRootModeEnabled() {
        grep -qE "DropRootPrivileges=(true|no_ambient)" "${AGENT_RUNTIME_CONF_PATH}/${INSTALLATION_CONF_FILE_NAME}"
}

runAutostartAddingTool() {
        local prefix="${1}"
        local file="${2}"
        local suffix="${3}"
        local output

        if isNonRootModeEnabled && printf '%s' "${prefix}" | grep -q "chkconfig"; then
                local action="chkconfig-add"
                if printf '%s' "${prefix}" | grep -q -- "--del"; then
                        action="chkconfig-del"
                fi
                toLogInfo "Using ${AGENT_OS_CONFIG_BIN} ${action}-${file} to modify autostart"
                output="$("$(getOsConfigBinPath)" "${action}-${file}" 2>&1)"
        else
                local command="${prefix}${file} ${suffix}"
                toLogInfo "Executing ${command}"
                output="$(${command} 2>&1)"
        fi
        local status=$?

        if [ "${output}" ]; then
                toLogAdaptive ${status} "${output}"
        fi

        return ${status}
}

readLinkFromLs() {
        local path="${1}"
        local result="${path}"
        local lsOutput="$(ls -dl "${path}" 2>/dev/null)"
        if printf '%s' "${lsOutput}" | grep -q " -> "; then
                local parsedLinkTarget="$(printf '%s' "${lsOutput}" | sed 's|^.* -> ||')"
                if [ "${parsedLinkTarget}" ]; then
                        result="${parsedLinkTarget}"
                else
                        toLogWarning "Failed to parse ls output '${lsOutput}'"
                fi
        fi
        printf '%s' "${result}"
}

readLink() {
        local args=-e
        local path="${1}"
        if [ "${2}" ]; then
          args="${1}"
          path="${2}"
        fi

        (
                if [ "${ARCH_ARCH}" = "AIX" ]; then 
                        PATH="${PATH}:/opt/freeware/bin"
                fi

                if isAvailable readlink; then
                        #shellcheck disable=SC2086
                        readlink ${args} "${path}"
                else
                        toLogInfo "readlink command not found, falling back to parsing ls output"
                        readLinkFromLs "${path}"
                fi
        )
}

listProcesses() {
        ps -eo pid,args 2>/dev/null | grep -E "${1}" | grep -v grep
}

isAvailable() {
        command -v "${1}" >/dev/null 2>&1
}

setValueInConfigFile() {
        local key="${1}"
        local separator="${2}"
        local value="${3}"
        local configFile="${4}"
        local hideValue="${5}"
        local keySearchPattern="^${key}[ \\t=]"

        local logEntry="${key}${separator}${value}"
        if [ "${hideValue}" ]; then
                logEntry="${key}${separator}***"
        fi

        {
                if ! grep -q "${keySearchPattern}" "${configFile}"; then
                        awk '{print $0}' <"${configFile}" && printf '%s\n' "${key}${separator}${value}"
                else
                        sed "s|${keySearchPattern}.*|${key}${separator}${value}|" "${configFile}"
                fi
        } >"${configFile}.tmp"

        if [ $? -ne 0 ]; then
                toLogWarning "Failed to set '${logEntry}' in ${configFile}"
                rm -f "${configFile}.tmp"
                return
        fi

        mv -f "${configFile}.tmp" "${configFile}"
        toLogInfo "Set '${logEntry}' in ${configFile}"
}
readonly GLIBC_SUPPORTED_VERSION=2.5
readonly GLIBC_SUPPORTED_VERSION_MINIMAL_PATCH=42
readonly UNPACK_BINARY=base64
readonly UNPACK_BINARY_ARGS="-di"
readonly ARCH_HAS_DUMPPROC=true
readonly ARCH_HAS_NETWORKAGENT=true
readonly ARCH_HAS_PLUGINAGENT=true
readonly ARCH_HAS_PROCESSAGENT=true
readonly ARCH_HAS_SELINUX=true
readonly ARCH_ARCH="X86"
#shellcheck disable=SC2034
PA_RECOVERY_ENABLED="false"

arch_readLine() {
        local line="${1}"
        local resp=
        read -rp "${line}" resp
        printf '%s' "${resp}"
}

arch_getBitnessForArch() {
        local arch="$(echo "${1}" | tr '[:lower:]' '[:upper:]')"
        local bitness=32

        if [ "${arch}" = "X86_64" ] || [ "${arch}" = "IA64" ] ; then
                bitness=64
        fi

        printf '%s' "${bitness}"
}

arch_moveNewBinariesIntoLibFolders() {
        toConsoleInfo "Moving new binaries into lib folders..."
        local downloadsDir="downloads"
        #atomic move of all binaries - first to local filesystem where we are installed - this might not be atomic
        #then to their final destination - this is atomic
        rm -rf "${INSTALL_PATH}/agent/${downloadsDir}"
        mkdir -p "${INSTALL_PATH}/agent/${downloadsDir}"

        if [ "$(getBitSuffix)" -eq 64 ] ; then
                mv -f "${TMP_FOLDER}/${downloadsDir}/${AGENT_VERSION_DIR}/linux-x86-64" "${INSTALL_PATH}/agent/${downloadsDir}/lib64"
                mv -f "${TMP_FOLDER}/${downloadsDir}/${AGENT_VERSION_DIR}/linuxmusl-x86-64" "${INSTALL_PATH}/agent/${downloadsDir}/libmusl64"
        fi

        mv -f "${TMP_FOLDER}/${downloadsDir}/${AGENT_VERSION_DIR}/linux-x86-32" "${INSTALL_PATH}/agent/${downloadsDir}/lib"

        for dir in lib lib64 libmusl64
        do
                if [ ! -d "${INSTALL_PATH}/agent/${downloadsDir}/${dir}" ]; then
                        continue
                fi

                mkdir -p "${INSTALL_PATH}/agent/${dir}"
                mv -f "${INSTALL_PATH}/agent/${downloadsDir}/${dir}"/* "${INSTALL_PATH}/agent/${dir}/"
                rmdir "${INSTALL_PATH}/agent/${downloadsDir}/${dir}"
        done

        rmdir "${INSTALL_PATH}/agent/${downloadsDir}"

        toLogInfo "Moving done."
}

arch_chmod4FilesRecursively(){
   local dir="${1}"
   local type="${2}"
   local mask="${3}"
   find "${dir}" -type "${type}" -print0 | xargs -r -0 chmod "${mask}"
}

arch_chmod4FilesWithMindepth(){
   local dir="${1}"
   local mindepth="${2}"
   local mask="${3}"
   find "${dir}" -mindepth "${mindepth}" -print0 | xargs -r -0 chmod "${mask}"
}

arch_copyPaRecoveryInitScriptToDirectory() {
        true
}

arch_setupToolFolder() {
        toLogInfo "Setup tools folder..."
        cp -fR "${TMP_FOLDER}/tools" "${AGENT_INSTALL_PATH}/"
        chmod 750 -R "${AGENT_INSTALL_PATH}/tools"
        find "${AGENT_INSTALL_PATH}/tools" -type d -print0 | xargs -r -0 chmod 755
        toLogInfo "Setup tools done."
}

arch_setupResFolder() {
        toLogInfo "Setup res folder..."
        moveOrCopyFolder "${TMP_FOLDER}/agent/res" "${AGENT_INSTALL_PATH}/"
        toLogInfo "Setup res done."
}

arch_checkCompatibility() {
        local platform="$(uname | sed -e 's/_.*//' | sed -e 's/\///' | tr '[:lower:]' '[:upper:]')"
        if [ "${platform}" != "LINUX" ]; then
                printf "Cannot determine platform or platform not supported: <%s>" "${platform}"
                return 1
        fi

        local arch="$(detectArchitecture)"
        if [ "${arch}" = "X86_64" ] || [ "${arch}" = "IA64" ] || [ "${arch}" = "I386" ] || [ "${arch}" = "I686" ] ; then
                arch="X86"
        else
                arch="$(uname -m | sed -e 's/i.86/x86/' | sed -e 's/i86pc/x86/' | sed -e 's/9000\/.*/parisc/' | sed -e 's/s390x/s390/' | sed -e 's/ppc64/ppc/' | tr '[:lower:]' '[:upper:]')"
        fi

        if [ "${arch}" != "X86" ]; then
                printf "Cannot determine architecture or architecture not supported: <%s>" "${arch}"
                return 1
        fi

        printf "Detected platform: %s arch: %s" "${platform}" "${arch}"
        return 0
}

arch_detectProcessAgentDirectoriesBasedOnLdd() {
        local lddResult32="$(ldd "${TMP_FOLDER}/others/sample32" 2>/dev/null | grep libc.so | awk '{ print $3 }')"
        #case for 64bit system without 32bit libraries installed
        if [ ! -z "${lddResult32}" ] ; then
                lddResult32="$(dirname "${lddResult32}")"
                readonly SYSTEM_LIB32="$(systemLibDirSanityCheck "${lddResult32}")"
        fi

        if [ "$(getBitSuffix)" -eq 64 ] ; then
                local lddResult64="$(ldd "${TMP_FOLDER}/others/sample64" | grep libc.so | awk '{ print $3 }')"
                lddResult64="$(dirname "${lddResult64}")"
                readonly SYSTEM_LIB64="$(systemLibDirSanityCheck "${lddResult64}")"
        fi
}

arch_runSample() {
        local bitness="${1}"
        local sampleBinary="${TMP_FOLDER}/others/sample${bitness}"
        chmod u+x "${sampleBinary}"

        local systemLibPrefix
        systemLibPrefix="$(arch_runCommandWithTimeout 5 "${sampleBinary}")"
        local exitCode=$?
        toLogInfo "System ${bitness}-bit libraries prefix returned by sample${bitness}: '${systemLibPrefix}', exit code = ${exitCode}"

        printf "%s" "${systemLibPrefix}"
        return ${exitCode}
}

arch_detectProcessAgentInstallationDirectories() {
        local useLddOutput=0

        local systemLib32Prefix
        systemLib32Prefix="$(arch_runSample 32)"
        local sampleExitCode=$?
        if [ -z "${systemLib32Prefix}" ]; then
                if [ "$(getBitSuffix)" -eq 32 ]; then
                        toLogWarning "This is a 32-bit platform, but sample32 failed to execute"
                        useLddOutput=1
                elif [ "${sampleExitCode}" -eq 0 ]; then
                        toLogWarning "This is a 64-bit platform with 32-bit libraries installed, but sample32 failed to determine their location"
                        useLddOutput=1
                else
                        toLogInfo "This is a 64-bit platform and 32-bit libraries were not detected"
                fi
        else
                systemLib32Prefix="$(systemLibDirSanityCheck "/${systemLib32Prefix}")"
                if [ -z "${systemLib32Prefix}" ]; then 
                        useLddOutput=1
                fi
        fi

        if [ "$(getBitSuffix)" -eq 64 ]; then
                local systemLib64Prefix="$(arch_runSample 64)"
                if [ -z "${systemLib64Prefix}" ]; then
                        toLogWarning "This is a 64-bit platform, but sample64 failed to execute"
                        useLddOutput=1
                else
                        systemLib64Prefix="$(systemLibDirSanityCheck "/${systemLib64Prefix}")"
                        if [ -z "${systemLib64Prefix}" ]; then
                                useLddOutput=1
                        fi
                fi
        fi

        if [ ${useLddOutput} -eq 1 ]; then
                toLogInfo "Using ldd output to detect system directories for dynamic libraries"
                arch_detectProcessAgentDirectoriesBasedOnLdd
        else
                readonly SYSTEM_LIB32="${systemLib32Prefix}"
                readonly SYSTEM_LIB64="${systemLib64Prefix}"
        fi
} 2>>"${LOG_FILE}"

arch_setRcShutdownFile() {
        true
}

arch_isUbuntu1204() {
        if [ ! -e /etc/os-release ]; then
                return 1
        fi

        local distributionName="$(. /etc/os-release; echo "${ID}" | tr '[:lower:]' '[:upper:]' | sed -e 's/^"//'  -e 's/"$//' | sed -e 's/[\/&]//g')"
        local distributionVersion="$(. /etc/os-release; echo "${VERSION_ID}")"
        if [ "${distributionName}" = "UBUNTU" ] && [ "${distributionVersion}" = "12.04" ]; then
                return 0
        else
                return 1
        fi
}

arch_processAgentUbuntu1204Fix() {
        if arch_isUbuntu1204; then
                if [ ! -z "${SYSTEM_LIB64}" ] && [ ! -z "${SYSTEM_LIB32}" ]; then
                        local commandOutput
                        toLogInfo "Creating /lib/lib32"
                        if [ ! -d /lib/lib32 ]; then
                                commandOutput=$(mkdir /lib/lib32 2>&1)
                                if [ $? -ne 0 ]; then
                                        toLogError "Cannot create /lib/lib32: ${commandOutput}"
                                fi
                        fi

                        toLogInfo "Creating symlink: /lib32/${AGENT_PROC_LIB} => /lib/lib32/${AGENT_PROC_LIB}"
                        if [ -h "/lib/lib32/${AGENT_PROC_LIB}" ]; then
                                rm -f "/lib/lib32/${AGENT_PROC_LIB}" 2>/dev/null
                                if [ $? -ne 0 ]; then
                                        toLogError "Cannot remove symlink: $(ls -alh "/lib/lib32/${AGENT_PROC_LIB}")"
                                fi
                        fi

                        commandOutput=$(ln -s "/lib32/${AGENT_PROC_LIB}" "/lib/lib32/${AGENT_PROC_LIB}" 2>&1)
                        if [ $? -ne 0 ]; then
                                toLogError "Symlink: /lib/lib32/${AGENT_PROC_LIB} cannot be created: ${commandOutput}"
                        fi
                fi
        fi
}

arch_removeProcessAgentUbuntu1204Fix() {
        if arch_isUbuntu1204; then
                if [ -h "/lib/lib32/${AGENT_PROC_LIB}" ]; then
                        toLogInfo "Removing symlink: /lib/lib32/${AGENT_PROC_LIB}"
                        rm -f "/lib/lib32/${AGENT_PROC_LIB}" 2>/dev/null
                fi

                if [ -d /lib/lib32 ]; then
                        toLogInfo "Removing /lib/lib32"
                        rmdir /lib/lib32 2>/dev/null
                fi
        fi
}

arch_copyProcessAgentLibraries() {
        local processAgent32Path="${1}"
        local processAgent64Path="${2}"
        local cpRemoveDestOption=
        toLogInfo "Process agent 32 bit install path: ${processAgent32Path}"
        toLogInfo "Process agent 64 bit install path: ${processAgent64Path}"

        if ! isDeployedViaContainer; then
                cpRemoveDestOption="--remove-destination"
        fi

        if [ ! -z "${processAgent32Path}" ]; then
                toLogInfo "Installing 32-bit process agent in: ${processAgent32Path}"

                if [ ! -d "${processAgent32Path}" ]; then
                        toLogInfo "Creating directory ${processAgent32Path}"
                        mkdir -p "${processAgent32Path}"
                fi

                toLogInfo "Executing: cp -f ${cpRemoveDestOption} ${INSTALL_PATH}/agent/lib/${AGENT_PROC_LIB} ${processAgent32Path}/"
                cp -f ${cpRemoveDestOption} "${INSTALL_PATH}/agent/lib/${AGENT_PROC_LIB}" "${processAgent32Path}/" 2>"${TMP_FOLDER}/processAgentInstall.error"
                if [ $? -ne 0 ]; then
                        toLogError "Error when installing process agent: $(cat "${TMP_FOLDER}/processAgentInstall.error")"
                fi
        fi

        if [ ! -z "${processAgent64Path}" ]; then
                toLogInfo "Installing 64-bit process agent in: ${processAgent64Path}"

                if [ ! -d "${processAgent64Path}" ]; then
                        toLogInfo "Creating directory ${processAgent64Path}"
                        mkdir -p "${processAgent64Path}"
                fi
                toLogInfo "Executing: cp -f ${cpRemoveDestOption} ${INSTALL_PATH}/agent/lib64/${AGENT_PROC_LIB} ${processAgent64Path}/"
                cp -f ${cpRemoveDestOption} "${INSTALL_PATH}/agent/lib64/${AGENT_PROC_LIB}" "${processAgent64Path}/" 2>"${TMP_FOLDER}/processAgentInstall.error"
                if [ $? -ne 0 ]; then
                        toLogError "Error when installing process agent: $(cat "${TMP_FOLDER}/processAgentInstall.error")"
                fi
        fi

}

arch_installProcessAgentOnHost() {
        arch_detectProcessAgentInstallationDirectories
        arch_copyProcessAgentLibraries "${SYSTEM_LIB32}" "${SYSTEM_LIB64}"
        arch_processAgentUbuntu1204Fix
}

arch_installProcessAgentOnContainer() {
        readonly SYSTEM_LIB32="${PA_FALLBACK_INSTALLATION_PATH}/lib32"
        readonly SYSTEM_LIB64="${PA_FALLBACK_INSTALLATION_PATH}/lib64"
        arch_copyProcessAgentLibraries "${SYSTEM_LIB32}" "${SYSTEM_LIB64}"
}

arch_createConfigWithSystemLibraryPaths() {
        printf '%s\n%s' "${SYSTEM_LIB32}" "${SYSTEM_LIB64}" >"${SYSTEM_LIB_DIRS_FILE}"
}

arch_getLibMacro() {
        local libMacro=
        if [ "$(getBitSuffix)" -eq 64 ]; then
                if [ "${SYSTEM_LIB32}" ]; then
                        libMacro="/\$LIB"
                else
                        libMacro=""
                fi
        else
                libMacro=""
        fi
        printf "%s" "${libMacro}"
}

arch_getSystemLibBase() {
        local detectedSystemLibBase=
        if [ "$(getBitSuffix)" -eq "64" ]; then
                detectedSystemLibBase="${SYSTEM_LIB64}"
                if [ "${SYSTEM_LIB32}" ]; then
                        if printf '%s' "${detectedSystemLibBase}" | grep -q "${PA_FALLBACK_INSTALLATION_PATH}"; then
                                detectedSystemLibBase="${PA_FALLBACK_INSTALLATION_PATH}/"
                        else
                                # dirname to get path without last folder (will be substituted with $LIB)
                                detectedSystemLibBase="$(dirname "${detectedSystemLibBase}")"
                        fi
                else
                        detectedSystemLibBase="${SYSTEM_LIB64}"
                fi
        else
                detectedSystemLibBase="${SYSTEM_LIB32}"
        fi

        if [ "${detectedSystemLibBase}" = "/" ]; then
                detectedSystemLibBase=
        fi

        printf "%s" "${detectedSystemLibBase}"
}

arch_getBinariesFolder() {
        local bitness="$(arch_getBitnessForArch "$(detectArchitecture)")"

        local binFolder=lib
        if [ "${bitness}" -eq 64 ]; then
                binFolder=lib64
        fi

        printf '%s' "${binFolder}"
}

arch_isSELinuxEnabled() {
        local seLinuxStatus="$(getenforce)"
        if [ "${seLinuxStatus}" = "Enforcing" ] || [ "${seLinuxStatus}" = "Permissive" ] ; then
                return 0
        else
                return 1
        fi
}

arch_checkSELinuxInstallationPathCompatibility() {
        if [ "${PARAM_INSTALL_SELINUX_POLICY}" = "no" ] || ! isAvailable semodule; then
                return 0
        fi

        if ! arch_isSELinuxEnabled; then
                return 0
        fi

        if [ -h "${INSTALL_PATH}" ] || [ "${PARAM_INSTALL_PATH}" != "${INSTALL_PATH}" ] || [ -h "${INSTALL_BASE}" ]; then
                if ! isAvailable semanage; then
                        return 1
                fi
        fi

        return 0
}

arch_checkGlibc() {
        local glibcVersion="$(ldd --version | awk 'NR==1{ print $NF }')"

        toLogInfo "Detected glibc version: ${glibcVersion}"

        if [ "$(format_version "${glibcVersion}")" -gt "$(format_version "${GLIBC_SUPPORTED_VERSION}")" ]; then
                return
        elif [ "$(format_version "${glibcVersion}")" -lt "$(format_version "${GLIBC_SUPPORTED_VERSION}")" ]; then
                 toConsoleError "We can't continue setup. The glibc version: ${glibcVersion} detected on your system isn't supported."
                 toConsoleError "To install ${AGENT_PRODUCT_NAME} you need at least glibc ${GLIBC_SUPPORTED_VERSION}."
                 toConsoleError "Stopping installation process..."
                 finishInstallation "${EXIT_CODE_GLIBC_VERSION_TOO_LOW}"
        fi

        if ! isAvailable rpm; then
                toLogInfo "RPM not detected - skipping glibc patch version check."
                return
        fi

        local glibcFullVersion="$(arch_runCommandWithTimeout 60 "rpm" "-q" "glibc" | tail -n 1)"
        if [ ! "${glibcFullVersion}" ]; then
                toConsoleError "Could not determine exact glibc version using RPM."
                finishInstallation "${EXIT_CODE_GLIBC_VERSION_TOO_LOW}"
        fi

        # fix for RedHat 5.x with unsufficient glibc 2.5 patch version
        local glibcPatchVersion="$(format_patch "${glibcFullVersion}")"
        if [ "$(format_version "${glibcVersion}")" -eq "$(format_version "${GLIBC_SUPPORTED_VERSION}")" ] && [ "${glibcPatchVersion}" -lt "${GLIBC_SUPPORTED_VERSION_MINIMAL_PATCH}" ]; then
                toConsoleError "glibc patch version: ${glibcPatchVersion} detected on your system is not supported, setup won't continue."
                toConsoleError "To install ${AGENT_PRODUCT_NAME} you need at least glibc ${GLIBC_SUPPORTED_VERSION}-${GLIBC_SUPPORTED_VERSION_MINIMAL_PATCH}."
                finishInstallation "${EXIT_CODE_GLIBC_VERSION_TOO_LOW}"
        fi
}

# 'timeout' requires gnu-coreutils8, i.e. it is not available on RHEL5, that's why we need this utility function
arch_runCommandWithTimeout() {
        local commandTimeout="${1}"
        shift
        local resultFile="/tmp/oneagent_commandResult_$$"
        local errorFile="/tmp/oneagent_commandError_$$"
        local loopErrorsFile="/tmp/oneagent_loopErrors_$$"

        toLogInfo "Executing $* with timeout ${commandTimeout} seconds"
        ("$@" > ${resultFile} 2>${errorFile} & child=$!
                while [ "${commandTimeout}" -gt 0 ]; do
                        toLogInfo "Time left: ${commandTimeout} pid: ${child}"
                        sleep 1
                        kill -0 "${child}" 2>/dev/null || exit 0
                        commandTimeout=$((commandTimeout - 1))
                done

                # Be nice, post SIGTERM first.
                # The 'exit 0' below will be executed if any preceeding command fails.
                toLogInfo  "Killing child: ${child} with SIGTERM"
                kill -s 15 "${child}" && kill -0 "${child}" || exit 0
                sleep 1
                toLogWarning "Killing child: ${child} with SIGKILL"
                kill -s 9 "${child}"

        ) 2>"${loopErrorsFile}"

        local errorOutput="$(cat "${errorFile}")"
        local commandOutput="$(cat "${resultFile}")"
        local loopErrors="$(cat "${loopErrorsFile}")"
        rm -f "${errorFile}" "${resultFile}" "${loopErrorsFile}"

        if [ -n "${errorOutput}" ]; then
                toLogInfo "Failed to execute command, error output: ${errorOutput}"
                if [ "${loopErrors}" ]; then
                        toLogInfo "Loop errors: ${loopErrors}"
                fi
                printf ""
                return 1
        else
                toLogInfo "Command executed successfully, output: ${commandOutput}"
                if [ "${loopErrors}" ]; then
                        toLogInfo "Loop errors: ${loopErrors}"
                fi
                printf '%s' "${commandOutput}"
                return 0
        fi
}

arch_getFilesystemInfo() {
        grep " ${1} " /proc/self/mounts
}

arch_getAccessRights() {
        stat --format='%A' "${1}"
}

readonly CONTAINER_INSTALLER_SCRIPT_NAME="Dynatrace-OneAgent-Linux.sh"
readonly CONTAINER_INSTALLER_PATH_ON_HOST="${INSTALL_PATH}/${CONTAINER_INSTALLER_SCRIPT_NAME}"

isAgentRunning() {
        local watchdogPID="$(getWatchdogPid)"
        local running="false"
        if [ -n "${watchdogPID}" ]; then running="true"; fi
        toLogInfo "Agent is running: ${running}"

        if isDeployedViaContainer; then
                local agentRunningInContainer="false"
                if isAgentRunningInContainer; then 
                        agentRunningInContainer="true";
                fi
                toLogInfo "Agent is running inside a container: ${agentRunningInContainer}"
        fi
}

initLog() {
        createLogDirsIfMissing
        toLogInfo "Uninstallation started."
        toLogInfo "Distribution: $(detectLinuxDistribution)"
        toLogInfo "Launched during upgrade: ${IS_UPGRADING}"
        toLogInfo "Command line: ${*}"
        isAgentRunning
}

finishLog() {
        toConsoleInfo "Done"
        toLogInfo "Uninstallation finished successfully."
        echo " " >> "${LOG_FILE}"
}

checkKernelVersionAtLeast() {
        local kernelVersionLong="$(uname -r | awk -F. '{print $1$2}')"
        local kernelVersion="$(echo "${kernelVersionLong}" | cut -c1-2)"
        if [ "${kernelVersion}" -ge "$1" ]; then
                return 1
        fi
        return 0
}

unmountRecoveryPoint() {
        local kernelAtLeast24=0
        checkKernelVersionAtLeast 24
        kernelAtLeast24=$?
        toLogInfo "Kernel version at least 2.4: ${kernelAtLeast24}"

        local count="$(mount | grep -c "${PA_RECOVERY_MOUNT_POINT}")"
        while [ "${count}" -gt 0 ]; do
                toLogInfo "Unmounting ${PA_RECOVERY_MOUNT_POINT}"
                if [  ${kernelAtLeast24} -ne 0 ]; then
                        commandErrorWrapper umount -l "${PA_RECOVERY_MOUNT_POINT}"
                else
                        commandErrorWrapper umount "${PA_RECOVERY_MOUNT_POINT}"
                fi

                local newCount="$(mount | grep -c "${PA_RECOVERY_MOUNT_POINT}")"
                if [ "${newCount}" -eq "${count}" ]; then
                        toLogWarning "Unmount failed, number of remaining mounts: ${count}. Aborting the unmount to prevent entering infinite loop"
                        break
                fi

                count=${newCount}
        done
}

turnOffProcessAgent() {
        if [ "${ARCH_HAS_PROCESSAGENT}" ]; then
                toConsoleInfo "Removing entries for preloading"
                changeProcessAgentState "disable"

                if mount | grep -q "${PA_RECOVERY_MOUNT_POINT}"; then
                        toLogInfo "Turning off process agent..."
                        commandErrorWrapper rm -f /etc/ld.so.preload
                        commandErrorWrapper cp -f "${PA_RECOVERY_MOUNT_POINT}"/ld.so.preload /etc/ld.so.preload
                        unmountRecoveryPoint
                        commandErrorWrapper rm -Rf "${PA_RECOVERY_MOUNT_POINT}"
                fi

                if ! grep -Eq "[[:alnum:]]" /etc/ld.so.preload 2>/dev/null; then
                        rm -f /etc/ld.so.preload
                fi
        fi
}

#Obtain PID of calling process, should be set only when the script is called from shellinstall.sh
setLogFileSuffixIfNeeded() {
        if [ -n "${1}" ]; then
                if echo "${1}" | grep -Eq '^[0-9]+$'; then
                        LOG_FILE="${INSTALLATION_LOG_DIR}/installation_${1}.log"
                fi
        fi
}

dumpproc_enableApport() {
        if [ ! -e "${UBUNTU_APPORT_CONFIG_PATH}" ]; then
                return
        fi

        if [ ! -e "${BACKUP_UBUNTU_APPORT_CONFIG}" ]; then
                toLogInfo "No backup apport config found. Simply enabling apport"
                printf "enabled=1" > "${UBUNTU_APPORT_CONFIG_PATH}" 2>> "${LOG_FILE}"
        fi

        toLogInfo "Restoring original apport config file to ${UBUNTU_APPORT_CONFIG_PATH}"
        cp "${BACKUP_UBUNTU_APPORT_CONFIG}" "${UBUNTU_APPORT_CONFIG_PATH}" 2>>"${LOG_FILE}"
        toLogInfo "Removing backup apport config file"
        rm -f "${BACKUP_UBUNTU_APPORT_CONFIG}" 2>>"${LOG_FILE}"
}

dumpproc_enableABRT() {
        if [ ! -e "${REDHAT_ABRT_SCRIPT_PATH}" ]; then
                return
        fi

        toLogInfo "Found RedHat ABRT app - enabling"
        ${REDHAT_ABRT_SCRIPT_PATH} start >>"${LOG_FILE}" 2>&1
        chkconfig abrt-ccpp on >>"${LOG_FILE}" 2>&1
}

dumpproc_restoreCorePatternFile() {
        if [ ! -e "${BACKUP_CORE_PATTERN_PATH}" ]; then
                return
        fi

        toLogInfo "Restoring original core_pattern file"
        toLogInfo "$("$(getOsConfigBinPath)" restore-core-pattern 2>&1)"
        rm -f "${BACKUP_CORE_PATTERN_PATH}" 2>>"${LOG_FILE}"
}

dumpproc_restoreCorePatternSysctl() {
        if grep -q "${SYSCTL_CORE_PATTERN_OPTION}" "${SYSCTL_PATH}" 2>/dev/null; then
                toLogInfo "Removing ${SYSCTL_PATH} '${SYSCTL_CORE_PATTERN_OPTION}' option"
                sed -i "/${SYSCTL_CORE_PATTERN_OPTION}.*/d" "${SYSCTL_PATH}" 2>>"${LOG_FILE}"
        else
                toLogInfo "${SYSCTL_CORE_PATTERN_OPTION} already removed"
        fi

        if [ -e "${BACKUP_SYSCTL_CORE_PATTERN_ENTRY_PATH}" ]; then
                toLogInfo "Restoring user-defined ${SYSCTL_CORE_PATTERN_OPTION} from backup"
                cat "${BACKUP_SYSCTL_CORE_PATTERN_ENTRY_PATH}" >>"${SYSCTL_PATH}" 2>>"${LOG_FILE}"
                toLogInfo "Removing backup of user-defined '${SYSCTL_CORE_PATTERN_OPTION}' entry for ${SYSCTL_PATH}"
                rm -f "${BACKUP_SYSCTL_CORE_PATTERN_ENTRY_PATH}" 2>>"${LOG_FILE}"
        fi
}

removeScriptsFromAutostart() {
        local prefix="${1}"
        local suffix="${2}"
 
        if ! runAutostartAddingTool "${prefix}" "${INITDFILE}" "${suffix}"; then
                toConsoleError "Failed to remove ${INITDFILE} from autostart. For details, see ${LOG_FILE}"
        fi

        if [ "${PA_RECOVERY_ENABLED}" = "true" ]; then
                if ! runAutostartAddingTool "${prefix}" "${PA_RECOVERY_SCRIPT}" "${suffix}"; then
                        toConsoleError "Failed to remove ${PA_RECOVERY_SCRIPT} from autostart. For details, see ${LOG_FILE}"
                fi
        fi
}

removeUnitFromSystemd() {
        local unit=${1}
        if [ ! -e "${SYSTEMD_UNIT_FILES_FOLDER}/${unit}" ]; then
                        toLogInfo "${unit} does not exist and will not be removed from ${INIT_SYSTEM_SYSTEMD} autostart"
                        return
        fi

        executeSystemctlCommand disable "${unit}"
        rm -f "${SYSTEMD_UNIT_FILES_FOLDER}/${unit}"
}

removeAIXAutostart() {
        if ! rmitab "${BRANDING_PRODUCTSHORTNAME_LOWER}"; then
                toConsoleError "Failed to remove ${INITDFILE} from autostart. For details, see ${LOG_FILE}"
        fi

        (echo "g/${INITDFILE}/d"; echo 'wq') | ex -s /etc/rc.shutdown
} 2>>"${LOG_FILE}"

removeSystemvAutostart() {
        toConsoleInfo "Removing ${AGENT_PRODUCT_NAME} from autostart"

        #Order of checking is important
        #For example oracle installer creates sometimes broken chkconfig script on ubuntu
        if [ -x /usr/bin/update-rc.d ]; then #Ubuntu
                removeScriptsFromAutostart "/usr/bin/update-rc.d -f " "remove"
        elif [ -x /usr/sbin/update-rc.d ]; then #Ubuntu
                removeScriptsFromAutostart "/usr/sbin/update-rc.d -f " "remove"
        elif [ -x /sbin/chkconfig ]; then #RedHat
                removeScriptsFromAutostart "/sbin/chkconfig --del "
        elif [ -x /usr/lib/lsb/install_initd ]; then #Suse
                removeScriptsFromAutostart "/usr/lib/lsb/install_initd ${INIT_FOLDER}/"
        elif isAvailable rmitab; then #AIX
                removeAIXAutostart
        else
                toConsoleError "Couldn't remove ${AGENT_PRODUCT_NAME} from autostart. Please do it manually."
        fi
}

removeSystemdAutostart() {
        local agentUnitFile="${SYSTEMD_UNIT_FILE_AGENT}"
        local agentProcUnitFile="${SYSTEMD_UNIT_FILE_AGENT_PROC}"

        removeUnitFromSystemd "${agentUnitFile}"
        removeUnitFromSystemd "${agentProcUnitFile}"
        executeSystemctlCommand daemon-reload
}

removeProcessAgent() {
        if [ "${ARCH_HAS_PROCESSAGENT}" ]; then
                local systemLib32=
                local systemLib64=
                { read -r systemLib32 ; read -r systemLib64 ; } < "${SYSTEM_LIB_DIRS_FILE}"

                toConsoleInfo "Removing ${AGENT_PROC} from system folders"

                if [ ! -z "${systemLib32}" ] ; then
                        rm -f "${systemLib32}/${AGENT_PROC_LIB}"
                        toConsoleInfo "Removing ${AGENT_PROC} from ${systemLib32}"
                fi
                if [ ! -z "${systemLib64}" ] ; then
                        rm -f "${systemLib64}/${AGENT_PROC_LIB}"
                        toConsoleInfo "Removing ${AGENT_PROC} from ${systemLib64}"
                fi

                arch_removeProcessAgentUbuntu1204Fix
        fi
}

removeSystemvInitScripts() {
        toConsoleInfo "Removing ${INITDFILE} from ${INIT_FOLDER}"
        rm -f "${INIT_FOLDER}/${INITDFILE}"
        if [ "${PA_RECOVERY_ENABLED}" = "true" ]; then
                rm -f "${INIT_FOLDER}/${PA_RECOVERY_SCRIPT}"
        fi
}

isAgentRunningInContainer() {
        local watchdogPID="$(getWatchdogPid)"
        if [ -z "${watchdogPID}" ]; then
                return 1
        fi

        isProcessRunningInContainer "${watchdogPID}"
}

stopAgentService() {
        if [ ! -f "${INIT_FOLDER}/${INITDFILE}" ]; then
                toLogWarning "Not stopping the agent because init script was not found"
                return
        fi

        toConsoleInfo "Using ${INIT_SYSTEM} to stop the agent"
        if [ "${INIT_SYSTEM}" = "${INIT_SYSTEM_SYSV}" ];  then
                executeInitScriptCommand stop "true"
        else
                executeSystemctlCommand stop "${SYSTEMD_UNIT_FILE_AGENT}"
        fi

        local remainingAgents="$(listProcesses "${AGENT_WATCHDOG}|${AGENT_BIN}|${AGENT_LOG_ANALYTICS}|${AGENT_NETWORK}|${AGENT_PLUGIN}|${AGENT_HELPER}")"
        if [ -n "${remainingAgents}" ]; then
                toLogWarning "Failed to stop following agents: ${remainingAgents}"
        fi
}

removeAutostartScripts() {
        if [ "${INIT_SYSTEM}" = "${INIT_SYSTEM_SYSV}" ] ; then
                removeSystemvAutostart
                removeSystemvInitScripts
        else
                removeSystemdAutostart
        fi
}

cleanUpFiles() {
        cd "${INSTALL_PATH}" || toLogError "Failed to change working directory to ${INSTALL_PATH}"

        toConsoleInfo "Cleaning up ${AGENT_INSTALL_PATH}. Part of configuration preserved in ${RUNTIME_DIR}"

        removeIfExists "${AGENTCONF_PATH}/runtime"

        local pathsToKeep="${AGENT_INSTALL_PATH}/bin|${AGENT_LOADER_LIB}"
        for dir in lib lib64 libmusl64; do
                pathsToKeep="${pathsToKeep}|${AGENT_INSTALL_PATH}/${dir}$"
        done

        if [ -e "${CONTAINER_DEPLOYMENT_CONF_FILE}" ]; then
                 pathsToKeep="${pathsToKeep}|${CONTAINER_DEPLOYMENT_CONF_FILE}|${AGENTCONF_PATH}$"
        fi

        pathsToKeep="${pathsToKeep}|${AGENT_STATE_FILE_PATH}"
        {
                find "${AGENT_INSTALL_PATH}"/* | grep -vE "${pathsToKeep}" | xargs rm -rf
        } 2>>"${LOG_FILE}"

        removeIfExists "${AGENT_RUNTIME_DIR}/runtime/agentconfigs"
}

initializeUninstallation() {
        setPATH
        setLogFileSuffixIfNeeded "${1}"
        local skipRootPrivilegesCheck="${2}"
        if [ "${skipRootPrivilegesCheck}" = "true" ] && [ "${IS_UPGRADING}" = "true" ]; then
                toConsoleInfo "Skipping root privileges check"
        else
                if ! checkRootAccess; then
                        toConsoleError "You must run uninstaller with root privileges"
                        exit "${EXIT_CODE_GENERIC_ERROR}"
                fi
        fi

        initLog "${@}"
        configureSignalHandling

        if isAgentRunningInContainer && ! isProcessRunningInContainer self; then
                toConsoleError "${AGENT_PRODUCT_NAME} is running inside a container, it must be stopped before proceeding with uninstallation"
                exit "${EXIT_CODE_AGENT_CONTAINER_RUNNING}"
        fi

        if [ "${IS_UPGRADING}" = "false" ]; then
                # write file for OS Agent that uninstallation started 
                echo "uninstall" >"${UNINSTALL_INFO_FILE_PATH}"
        fi
}

cleanUpDumpProc() {
        if [ "${ARCH_HAS_DUMPPROC}" ]; then
                dumpproc_restoreCorePatternSysctl
                dumpproc_restoreCorePatternFile
                dumpproc_enableABRT
                dumpproc_enableApport
        fi
}

checkIfUpgrade() {
        # if this file already exists it means that this script was started by upgrade script
        if [ ! -f "${UNINSTALL_INFO_FILE_PATH}" ] ; then
                readonly IS_UPGRADING="false"
        else
                readonly IS_UPGRADING="true"
        fi
}

cleanUpSELinux() {
        if [ "${ARCH_HAS_SELINUX}" ]; then
                if isAvailable semodule; then
                        removeContextsForCustomInstallationPath
                        toConsoleInfo "Removing ${AGENT_SHORT_NAME} SELinux policies."
                        cleanUpOldPolicies
                fi
        fi
}

restoreRuncBinaries() {
        local confFile="${1}"
        local copySuffix="-original"
        local runcConfigKey="RuncWrapperPaths"

        local runcPaths="$(sed -n "s/${runcConfigKey}=//p" "${confFile}")"
        local IFS=":"

        for path in ${runcPaths}; do 
                path="$(printf "%s" "${path}" | cut -d\; -f1)"
                if [ -e "${path}${copySuffix}" ]; then
                        if [ -e "${path}" ]; then
                                toConsoleInfo "Restored original ${path} file"
                                mv -f "${path}${copySuffix}" "${path}" 2>>"${LOG_FILE}"
                        else
                                toLogWarning "File ${path} does not exist. Removing ${path}${copySuffix}."
                                rm -f "${path}${copySuffix}"
                        fi
                else
                        toLogWarning "File ${path}${copySuffix} does not exist"
                fi
        done

        setValueInConfigFile "${runcConfigKey}" "=" "" "${confFile}"
}

cleanUpFilesDuringUninstall() {
        toLogInfo "This is a full uninstallation, cleaning up rest of the files"

        removeIfExists "${DOWNLOADS_DIRECTORY}"
        removeIfExists "${AGENT_STATE_FILE_PATH}"
        removeIfExists "${CONTAINER_DEPLOYMENT_CONF_FILE}"
        removeIfExists "${AGENTCONF_PATH}"
        removeIfExists "${AGENT_RUNTIME_CONF_PATH}/${LOG_ANALYTICS_CONF_FILE_NAME}"
        removeIfExists "${CONTAINER_INSTALLER_PATH_ON_HOST}"
}

main() {
        checkIfUpgrade
        initializeUninstallation "$@"
        checkInitSystem
        if ! setLocationOfInitScripts; then
                toLogWarning "Cannot determine location of init scripts."
        fi

        if ! isDeployedViaContainer; then
                turnOffProcessAgent
                stopAgentService
                cleanUpDumpProc
                removeAutostartScripts
        fi

        removeProcessAgent
        cleanUpFiles

        if [ "${IS_UPGRADING}" = "false" ]; then
                cleanUpSELinux
                restoreRuncBinaries "${AGENT_RUNTIME_CONF_PATH}/${INSTALLATION_CONF_FILE_NAME}"
                cleanUpFilesDuringUninstall
        fi

        finishLog
        exit "${EXIT_CODE_OK}"
}

################################################################################
#
# Script start
#
################################################################################
main "$@"