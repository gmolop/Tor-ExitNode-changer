@BASH - Tor Browser {ExitNodes} Changer
===

Bash script to change Tor's {ExitNodes} Country Codes from terminal
---

    Name         : Tor Browser {ExitNodes} Changer
    Description  : Bash script to change Tor's {ExitNodes} Country Codes from terminal
    Version      : 1.3
    Enviroment   : OS X / Unix
    Author       : gmo
    Proyect      : https://github.com/gmolop/Tor-ExitNode-changer
    Tested on    : OS X 10.12.3 / bash 3.2.57(1) / Tor Browser 6.5
    Country list : https://b3rn3d.herokuapp.com/blog/2014/03/05/tor-country-codes

Description
---

> This script will read, check and modify for you, your Tor config file named: `torrc`  
> The goal is to have the ability to change Tor Browser Exit Nodes in a easy way...  
> 
> ...I didn't find any easier way to have my Tor with a custom proxy than:

````shell
    $ tor es
````

> So here it is:

Install
---

1. Download script from source [tor_exitNode_changer.sh](https://github.com/gmolop/Tor-ExitNode-changer/blob/master/dist/tor_exitNode_changer.sh)
2. Make script executable <sup>[how to](#2-make-script-executable)</sup>
3. Create an Alias <sup>[how to](#3-create-alias-for-easy-access)</sup>
4. Set your start page at https://www.dnsleaktest.com/  <sup>[how to](#4-set-your-start-page-at-httpswwwdnsleaktestcom-or-similar)</sup>
5. Enjoy

*3 & 4 are optional but recommended*

Usage
---

Just type `tor` in your terminal, followed by [2 letter ISO3166 country code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)

````shell
    $ tor es
    $ tor de
    $ tor cl
    $ ...
````

Arguments
---

- Get your system language (if you want to contribute with `locale::message case $lang`) use:

````shell
        $ tor --lang
````

- To show a list of all country codes available in the script, use:

````shell
        $ tor --list
````

- UnComment the {Exit Node} line for `custom` node:

````shell
        $ tor --set enabled
````

- Comment the {Exit Node} line for `normal/default/random` nodes:

````shell
        $ tor --set disabled
````

- Manually edit `torrc` file:

````shell
        $ tor --edit
````

- Remove exitNode config from `torrc` file:

````shell
        $ tor --clean
````

How To
---

- #####<sup>(2)</sup> Make script executable

    ````shell
        $ cd /path/to/folder/
        $ chmod u+x tor_exitNode_changer.sh
    ```

- #####<sup>(3)</sup> Create alias for easy access

    ````shell
        $ cd ~/
        $ vim .bash_profile
            i
            alias tor='/path/to/folder/tor_exitNode_changer.sh'
            esc
            wq
        $ source .bash_profile
    ````

- #####<sup>(4)</sup> Set your start page at https://www.dnsleaktest.com/ <sup>(or similar)</sup>

        Command+,
        General tab
        Start page

Know issues, Disclaimer & Changelog
---

> Refere to main [readme file](https://github.com/gmolop/Tor-ExitNode-changer/blob/master/README.md).
