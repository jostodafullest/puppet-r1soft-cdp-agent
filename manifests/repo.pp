class serverbackup_cdp_agent::repo {
    case $operatingsystem {
        redhat, centos: {
            yumrepo { 'r1soft':
                baseurl     => 'http://repo.r1soft.com/yum/stable/$basearch/',
                descr       => 'R1Soft Repository Server',
                enabled     => 1,
                gpgcheck    => 0,
                name        => 'r1soft',
            }
        }
        ubuntu, debian: {
		include apt
            apt::source { 'r1soft-stable':
                location    => 'http://repo.r1soft.com/apt',
                release     => 'stable',
                repos       => 'main',
		include => { 
		 'src' => false,
		 },
                key         =>  {
		'id'	=> 'B1D53877',
		'source' => 'http://repo.r1soft.com/r1soft.asc',
		},
            }
        }
    }
}
