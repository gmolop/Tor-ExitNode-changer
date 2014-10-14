Tor Browser {Exit Nodes} Changer
===

Bash script to change Tor's {Exit Nodes} Country Codes from terminal
---

    Name          : Tor Browser {Exit Nodes} Changer
    Description   : Bash script to change Tor's {Exit Nodes} Country Codes from terminal
    Version       : 1.0
    Enviroment    : OS X / Unix
    Author        : gmo
    Proyect       : https://github.com/gmolop/Tor-ExitNode-changer
    Tested on     : OS X 10.9.5 / bash 3.2.51(1) / Tor Browser Bundle 3.6.5
    Country list  : https://b3rn3d.herokuapp.com/blog/2014/03/05/tor-country-codes

Description
---

This script will read, check and modify for you, your Tor config file named: `torrc`  
The goal is to have the ability to change Tor Browser Exit Nodes in a easy way...  

...I didn't find any easier way to have my Tor with a custom proxy than:

    $ tor es

So here it is:

Install
---

1. Download script from source
2. Make script executable
3. Create an Alias
4. Set your start page at https://www.dnsleaktest.com/
5. Enjoy

*3 & 4 are optional but recommended*  

Usage
---

Just type `tor` in your terminal, followed by [2 letter ISO3166 country code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)

    $ tor es
    $ tor de
    $ tor cl
    $ ...

Arguments
---

- ####Get your system language (if you want to contribute with `locale::message case $lang`) use:

        $ tor --lang

- ####To show a list of all country codes available in the script, use:

        $ tor --list

- ####UnComment the {Exit Node} line for `custom` node:

        $ tor --set enabled

- ####Comment the {Exit Node} line for `normal/default/random` nodes:

        $ tor --set disabled

- ####Manually edit `torrc` file:

        $ tor --edit

- ####Remove exitNode config from `torrc` file:

        $ tor --clean

How To
---

- ####(2) Make script executable

        $ cd /path/to/folder/
        $ chmod u+x tor_exitNode_changer.sh

- ####(3) Create alias for easy access

        $ cd ~/
        $ vim .bash_profile
            i
            alias tor='/path/to/folder/tor_exitNode_changer.sh'
            esc
            wq
        $ source .bash_profile

- ####(4) Set your start page at https://www.dnsleaktest.com/ (or similar)

        Command+,
        General tab
        Start page

Know issues
---

- With some countries, Tor Browser stuck in `Connecting window...` but I don't know if it's because that language is deprecated in Node list or is just that Tor can't find a proper proxy in that specific moment.  
In this case, click on exit button and open it with another country (or disable for random)

Disclaimer
---

- It was a personal need that ended up in this code. I thought that would be helpful for others, so I shared here.  
Use as you want, test yourself, and modify as you like but if you find any bug or want to improve it in any way, feel free to comment, fork or share your suggestions here so all can be benefit of your suggestion.

Changelog
---

    v1.0 // 14-oct-14
        first release
