define r1soft_cdp_agent::key {
    exec { "/usr/bin/r1soft-setup --get-key ${name}":
        creates     => '/usr/sbin/r1soft/conf/server.allow/${name}',
        require     => Package['r1soft-cdp-enterprise-agent'],
        logoutput   => on_failure,
    }
}