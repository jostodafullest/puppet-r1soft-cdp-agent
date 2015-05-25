class serverbackup_cdp_agent::packages {
    case $operatingsystem {
        centos, redhat: {
            if !defined(Package['kernel-devel']) {
                package { 'kernel-devel':
                    ensure => installed,
                    before => Package['r1soft-cdp-enterprise-agent'],
                }
            }

            if !defined(Package['kernel-headers']) {
                package { 'kernel-headers':
                    ensure => installed,
                    before => Package['r1soft-cdp-enterprise-agent'],
                }
            }
        }
        debian, ubuntu: {
            # proxmox support
            if $kernelrelease  =~ /pve/ {
                package { "pve-headers-${kernelrelease}":
                    ensure  => installed,
                    require => Class['serverbackup_cdp_agent::repo'],
                    before => Package['r1soft-cdp-enterprise-agent'],
                }
            }
            else {
                package { "linux-headers-${kernelrelease}":
                    ensure  => installed,
                    require => Class['serverbackup_cdp_agent::repo'],
                    before => Package['r1soft-cdp-enterprise-agent'],
                }
            }
        }
        default: {
            notify("Unrecognized operating system, you may need to install some kernel development packages yourself")
        }
    }

    package { 'r1soft-cdp-enterprise-agent':
        ensure  => installed,
        require => Class['serverbackup_cdp_agent::repo'],
    }
}
