@BATCH - Tor Browser {Exit Nodes} Changer
===

Batch script to change Tor's {Exit Nodes} Country Codes from file
---

    Name         : Tor Browser {Exit Nodes} Changer
    Description  : Batch script to change Tor's {Exit Nodes} Country Codes from file
    Version      : 1.2
    Enviroment   : Windows CMD Shell
    Author       : gmo
    Proyect      : https://github.com/gmolop/Tor-ExitNode-changer
    Tested on    : Windows 10 pro / cmd.exe 10.0.10586.0 / Tor Browser 5.5.5 (based on Mozilla Firefox 38.8.0)

Description
---

> This is a port from Unix/OS X version, this script will read, check and modify  
> for you, your Tor config file named: `torrc`  
> The goal is to have the ability to change Tor Browser Exit Nodes in a easy way...  
> 
> ...I didn't find any easier way to have my Tor with a custom proxy than:

    Double click, set and go!

> So here it is:

Install
---

1. Download script from source [tor_exitNode_changer.bat](https://github.com/gmolop/Tor-ExitNode-changer/blob/master/dist/tor_exitNode_changer.bat)
2. Copy/Move to the same `torrc` file folder <sup>Normally in: <TOR_FOLDER>/Browser/TorBrowser/Data/Tor</sup>
3. Create an Shortcut Access to Desktop  <sup>(for say something...)</sup>
4. Set your start page at https://www.dnsleaktest.com/  <sup>[how to](#4-set-your-start-page-at-httpswwwdnsleaktestcom-or-similar)</sup>
5. Enjoy

*3 & 4 are optional but recommended*

Usage
---

Just start `tor` from the Shortcut and set up the [2 letter ISO3166 country code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) in the popup window.

    -------------------------------------------------
    | ExitNodes                                     |
    -------------------------------------------------
    | Enter ISO3166 country code:        ---------- |
    |                                    | ACCEPT | |
    | ---------------------------        ---------- |
    | | GB                      |        | CANCEL | |
    | ---------------------------        ---------- |
    -------------------------------------------------

How To
---

- #####<sup>(4)</sup> Set your start page at https://www.dnsleaktest.com/ <sup>(or similar)</sup>

        Settings,
        General tab
        Start page

Know issues, Disclaimer & Changelog
---

> Refere to main [readme file](https://github.com/gmolop/Tor-ExitNode-changer/blob/master/README.md).