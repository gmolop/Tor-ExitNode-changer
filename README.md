Tor Browser {ExitNodes} Changer
===

Change Tor's {ExitNodes} Country Codes easily!
---

    Name         : Tor Browser {ExitNodes} Changer
    Description  : Bash script to change Tor's {ExitNodes} Country Codes
    Version      : 1.3
    Enviroment   : OS X / Unix / Windows
    Author       : gmo
    Proyect      : https://github.com/gmolop/Tor-ExitNode-changer

Description
---

> This script will read, check and modify for you, your Tor config file named: `torrc`  
> Then it will close the browser (if it was already opened) and relaunch with the new config.
>  
> The goal is to have the ability to change Tor Browser Exit Nodes in a easy way...  

Unix/OS X version
---
Use  : [tor_exitNode_changer.sh](https://github.com/gmolop/Tor-ExitNode-changer/blob/master/dist/tor_exitNode_changer.sh)  
Info : [info_osx-unix.md](https://github.com/gmolop/Tor-ExitNode-changer/blob/master/info_osx-unix.md)  

Windows version
---
Use  : [tor_exitNode_changer.bat](https://github.com/gmolop/Tor-ExitNode-changer/blob/master/dist/tor_exitNode_changer.bat)  
Info : [info_windows.md](https://github.com/gmolop/Tor-ExitNode-changer/blob/master/info_windows.md)  

Know issues
---

> If `torrc` file is empty, you will need to manually write `ExitNodes {IT}` (IT is an example), (can be done with `tor --edit`).  
> With some countries, Tor Browser stuck in `Connecting window...` but I don't know if it's because that language is deprecated in Node list or is just that Tor can't find a proper proxy in that specific moment.  
> In this case, relaunch and/or wait

Changelog
---

> Refer to [changelog file](https://github.com/gmolop/Tor-ExitNode-changer/blob/master/CHANGELOG.md).

Disclaimer
---

> It was a personal need that ended up in this code. I thought that would be helpful for others, so I shared here.  
> Use as you want, test yourself, and modify as you like but if you find any bug or want to improve it in any way, feel free to comment, fork or share your suggestions here so all can be benefit of your suggestion.