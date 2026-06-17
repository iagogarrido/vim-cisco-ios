" Vim syntax file
" Language:     Cisco IOS config file
" Last Change:  2008-07-16
"
if exists("b:current_syntax") && b:current_syntax == 'cisco'
	finish
endif

setlocal iskeyword+=-

" --------------------------------------------------------------------------
" Comments
" --------------------------------------------------------------------------
syn match ciscoComment	"^\s*!.*$"
hi def link ciscoComment Comment

" --------------------------------------------------------------------------
" IP addresses
" --------------------------------------------------------------------------
syn match ciscoIpAddr /\<\(25[0-5]\|2[0-4][0-9]\|[01]\?[0-9][0-9]\?\)\.\(25[0-5]\|2[0-4][0-9]\|[01]\?[0-9][0-9]\?\)\.\(25[0-5]\|2[0-4][0-9]\|[01]\?[0-9][0-9]\?\)\.\(25[0-5]\|2[0-4][0-9]\|[01]\?[0-9][0-9]\?\)\>/
hi def link ciscoIpAddr	Number

" --------------------------------------------------------------------------
" Interface names (full names + abbreviated)
" --------------------------------------------------------------------------
" Full names
syntax match ciscoIfName /\<\(Loopback\|Tunnel\|Dialer\)[0-9][0-9]*/
syn match ciscoIfName +\<\(Ethernet\|FastEthernet\|GigabitEthernet\|TenGigabitEthernet\|Serial\)[0-9][0-9]*/[0-9][0-9]*\(/[0-9][0-9]*\)\?\(\.[0-9][0-9]*\)\?+
syn match ciscoIfName +\<\(Port-channel\|Vlan\)[0-9][0-9]*\([\/.][0-9][0-9]*\)*+
syn match ciscoIfName +\<\(Management\|Null\)[0-9][0-9]*+
syn match ciscoIfName +\<ATM[0-9][0-9]*\(/[0-9][0-9]*\)*\(\.[0-9][0-9]*\)\?+
" Abbreviated forms (Gi, Fa, Se, Lo, Tu, Di)
syn match ciscoIfName /\<\(Gi\|Fa\|Se\|Lo\|Tu\|Di\)[0-9][0-9]*\([\/.][0-9][0-9]*\)*/
" Very short forms (g, gi, gig, f, fa, s, se, e, eth, t, tu, lo, d, di, vl, po)
syn match ciscoIfName /\<\([Gg][Ii]\?[Gg]\?\)[0-9][0-9]*[\/.][0-9][0-9]*\([\/.][0-9][0-9]*\)*/
syn match ciscoIfName /\<\([Ff][Aa]\?\)[0-9][0-9]*[\/.][0-9][0-9]*\([\/.][0-9][0-9]*\)*/
syn match ciscoIfName /\<\([Ss][Ee]\?\)[0-9][0-9]*[\/.][0-9][0-9]*\([\/.][0-9][0-9]*\)*/
syn match ciscoIfName /\<\([Ee][Tt][Hh]\?\)[0-9][0-9]*[\/.][0-9][0-9]*\([\/.][0-9][0-9]*\)*/
syn match ciscoIfName /\<\([Tt][Uu]\?\)[0-9][0-9]*\([\/.][0-9][0-9]*\)*/
syn match ciscoIfName /\<\([Dd][Ii]\?\)[0-9][0-9]*\([\/.][0-9][0-9]*\)*/
syn match ciscoIfName /\<\([Ll][Oo]\)[0-9][0-9]*\([\/.][0-9][0-9]*\)*/
syn match ciscoIfName /\<\([Vv][Ll]\)[0-9][0-9]*\([\/.][0-9][0-9]*\)*/
syn match ciscoIfName /\<\([Pp][Oo]\)[0-9][0-9]*\([\/.][0-9][0-9]*\)*/
hi def link ciscoIfName Identifier
" Interface range suffix (only valid inside 'interface range')
syn match ciscoIfNameRange contained "-\s*\d\+"
" Error for range suffix outside 'interface range'
syn match ciscoInterfaceRangeError contained "-\s*\d\+"

" --------------------------------------------------------------------------
" Generic word (used by nextgroup in named items)
" --------------------------------------------------------------------------
syn match ciscoWord contained "[a-zA-Z0-9-_]\+"
hi def link ciscoWord String

" --------------------------------------------------------------------------
" Keyword highlighting (single-word commands, no region conflict)
" --------------------------------------------------------------------------
syn keyword ciscoKeyword hostname enable banner service ntp logging alias clock end exit reload write copy delete erase format login password exec transport motd no default
syn keyword ciscoKeyword aaa radius tacacs key key-chain arp bridge cdp class-map control-plane controller dialer dial-peer errdisable flow frame-relay gateway glbp hsrp inspect lacp license lldp mac-address-table mls monitor mpls mst nat netconf object object-group parser policy-map power prefix-list privilege rate-limit redundancy restconf rmon schedule scheduler security session sflow snmp spanning-tree ssh ssl stack standby static storm-control subscriber switchport terminal test timeout traceroute track tunnel udld upgrade vlan vmps vpn vrf vrrp vtp webvpn web
syn match ciscoKeyword "^\s*\(snmp-server\|ip domain\|ip ssh\|ip http\|ip tcp\|ip arpa\|ip cef\|ip routing\|ip subnet-zero\|ip classless\|ip default-gateway\|ip name-server\|ip dhcp\|ip vrf\|ip multicast-routing\|ip igmp\|ip pim\|ip mroute\)\s"
hi def link ciscoKeyword Keyword

" --------------------------------------------------------------------------
" Username region (matchgroup highlights just "username")
" --------------------------------------------------------------------------
syn region ciscoUsernames matchgroup=ciscoUsernameKw start=+^username\s+ end=+^\S+me=s-1 fold

" --------------------------------------------------------------------------
" Ip host region (matchgroup highlights just "ip host")
" --------------------------------------------------------------------------
syn region ciscoIpHosts matchgroup=ciscoIpHostKw start=+^ip host\s+ end=+^\S+me=s-1 fold

" --------------------------------------------------------------------------
" Line region (matchgroup highlights just "line")
" --------------------------------------------------------------------------
syn region ciscoLines matchgroup=ciscoLineKw start=+^line\s+ end=+^\S+me=s-1 fold contains=ciscoIpAddr,ciscoComment,ciscoLineKeyword
syn keyword ciscoLineKeyword contained login password exec transport autocommand privilege rotary session-timeout exec-timeout modem speed location

" --------------------------------------------------------------------------
" Interface region (matchgroup highlights just "interface")
" --------------------------------------------------------------------------
syn region ciscoInterfaces matchgroup=ciscoStartKw start=+^interface\s+ end=+^\S+me=s-1 fold contains=ciscoIpAddr,ciscoIfName,ciscoComment,ciscoInterfaceKeyword,ciscoInterfaceRangeError,ciscoInterfaceCommaError
syn match ciscoInterfaceCommaError contained ",\s*[A-Za-z]\S*\d"
syn keyword ciscoInterfaceKeyword contained shutdown description duplex speed mtu bandwidth delay negotiation auto media-type mac-address helper-address standby vrrp hsrp spanning-tree switchport channel-group load-interval service-policy rate-limit hold-queue no

" --------------------------------------------------------------------------
" Interface range region (matchgroup highlights just "interface range")
" --------------------------------------------------------------------------
syn region ciscoInterfaceRanges matchgroup=ciscoInterfaceRangeKw start=+^interface range\s+ end=+^\S+me=s-1 fold contains=ciscoIpAddr,ciscoIfName,ciscoIfNameRange,ciscoComment,ciscoInterfaceKeyword

" --------------------------------------------------------------------------
" Router region (matchgroup highlights just "router")
" --------------------------------------------------------------------------
syn region ciscoRouters matchgroup=ciscoRouterKw start=+^router\s+ end=+^\S+me=s-1 fold contains=ciscoIpAddr,ciscoIfName,ciscoComment,ciscoRouterKeyword
syn keyword ciscoRouterKeyword contained network neighbor redistribute default-information distance maximum-paths passive-interface router-id area timers summary-address version auto-cost log-adjacency-changes no

" --------------------------------------------------------------------------
" IP route (matchgroup highlights just "ip route")
" --------------------------------------------------------------------------
syn region ciscoIpRoutes matchgroup=ciscoIpRouteKw start=+^ip route\s+ end=+^\S+me=s-1 fold contains=ciscoIpAddr,ciscoIfName,ciscoComment

" --------------------------------------------------------------------------
" IP access-list (matchgroup highlights just "ip access-list")
" --------------------------------------------------------------------------
syn region ciscoIpAccessLists matchgroup=ciscoIpAclKw start=+^ip access-list\s+ end=+^\S+me=s-1 fold contains=ciscoIpAccessListNamed,ciscoIpAddr,ciscoIfName,ciscoComment,ciscoAclKeywords,ciscoAclOperator,ciscoAclProtocol,ciscoAclDirection,ciscoAclLog
syn match ciscoIpAccessListNamed contained "\<\(standard\|extended\)\s" nextgroup=ciscoWord skipwhite
syn keyword ciscoAclKeywords contained skipwhite host any permit deny remark evaluate
syn keyword ciscoAclOperator contained skipwhite eq ne gt lt range
syn keyword ciscoAclProtocol contained ip tcp udp icmp igmp gre esp ahp eigrp nos ospf pim rsvp vrrp
syn keyword ciscoAclDirection contained in out
syn keyword ciscoAclLog contained log log-input
hi def link ciscoAclKeywords Special
hi def link ciscoAclOperator Special
hi def link ciscoAclProtocol Type
hi def link ciscoAclDirection Special
hi def link ciscoAclLog Special
hi def link ciscoIpAccessListNamed Type

" --------------------------------------------------------------------------
" Access-list (matchgroup highlights just "access-list")
" --------------------------------------------------------------------------
syn region ciscoAccessLists matchgroup=ciscoAclKw start=+^access-list\s+ end=+^\S+me=s-1 fold contains=ciscoIpAddr,ciscoIfName,ciscoComment,ciscoAclKeywords,ciscoAclOperator,ciscoAclProtocol,ciscoAclDirection,ciscoAclLog

" --------------------------------------------------------------------------
" Route-map (matchgroup highlights just "route-map")
" --------------------------------------------------------------------------
syn region ciscoRouteMaps matchgroup=ciscoRouteMapKw start=+^route-map\s+ end=+^\S+me=s-1 fold contains=ciscoIpAddr,ciscoIfName,ciscoComment,ciscoRouteMapKeyword
syn keyword ciscoRouteMapKeyword contained match set continue description no

" --------------------------------------------------------------------------
" Crypto (ISAKMP, IPsec, map) — matchgroup highlights just "crypto isakmp" etc.
" --------------------------------------------------------------------------
syn region ciscoCryptoIsakmp matchgroup=ciscoCryptoIsakmpKw start=+^crypto isakmp\s+ end=+^\S+me=s-1 fold contains=ciscoCryptoKeyword,ciscoComment
syn region ciscoCryptoIsakmpKeys matchgroup=ciscoCryptoIsakmpKeysKw start=+^crypto isakmp key\s+ end=+^\S+me=s-1 fold contains=ciscoCryptoKeyword,ciscoComment
syn region ciscoCryptoIpsecTses matchgroup=ciscoCryptoIpsecKw start=+^crypto ipsec transform-set\s+ end=+^\S+me=s-1 fold contains=ciscoCryptoKeyword,ciscoComment
syn region ciscoCryptoMaps matchgroup=ciscoCryptoMapKw start=+^crypto map\s+ end=+^\S+me=s-1 fold contains=ciscoIpAddr,ciscoCryptoKeyword,ciscoComment
syn keyword ciscoCryptoKeyword contained encryption authentication group lifetime hash set transform-set peer match address pre-shared-key isakmp exit no

" --------------------------------------------------------------------------
" Matchgroup highlight links — keyword at start of each region
" --------------------------------------------------------------------------
hi def link ciscoStartKw Type
hi def link ciscoRouterKw Type
hi def link ciscoIpRouteKw Type
hi def link ciscoIpAclKw Type
hi def link ciscoAclKw Type
hi def link ciscoRouteMapKw Type
hi def link ciscoCryptoIsakmpKw Type
hi def link ciscoCryptoIsakmpKeysKw Type
hi def link ciscoCryptoIpsecKw Type
hi def link ciscoCryptoMapKw Type
hi def link ciscoUsernameKw Type
hi def link ciscoIpHostKw Type
hi def link ciscoLineKw Type
hi def link ciscoInterfaceKeyword Keyword
hi def link ciscoInterfaceRangeKw Type
hi def link ciscoIfNameRange Identifier
hi def link ciscoInterfaceRangeError Error
hi def link ciscoInterfaceCommaError Error
hi def link ciscoRouterKeyword Keyword
hi def link ciscoRouteMapKeyword Keyword
hi def link ciscoCryptoKeyword Keyword
hi def link ciscoLineKeyword Keyword

set foldmethod=syntax

if !exists('b:current_syntax')
   let b:current_syntax = "cisco"
endif

" vim: set ts=4
