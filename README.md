Mjolnir Bxn
===

![Vikings](http://orig13.deviantart.net/636c/f/2010/227/6/a/dwarf_shield_by_roblfc1892.jpg)

This Boxen version is specifically tailored for Team Mjolnir. We decided to
maintain our own to strictly comply with the contributing standards and enforce
testing and stability for each release.

- [@pongstr](https://github.com/pongstr)

Getting Started
---

Make sure you install the latest XCode and XCode Commandline Tools. After the
XCode installation, run it and verify the installation after you see the
welcome screen, you're good to go let's get your SSH Keys setup for Github
and Bitbucket:

```bash
# Let's cURL this dotfile that will make our life easier
$ curl -# -L -o setup https://raw.githubusercontent.com/pongstr/dotfiles/master/init/.gituser

# Make it executable and run it, follow instructions and you're golden
$ chmod +x setup && ./setup
```

The Setup
---

1. Go to [https://bxnweb.herokuapp.com](https://bxnweb.herokuapp.com)
1. Login using your Github Account
1. Copy + Paste the one liner to your Terminal
1. Grab a coffee, the internet is slow as fuck.

or you can manually run it:

```bash
$ sudo mkdir -p /opt/boxen
$ sudo chown ${USER}:staff /opt/boxen
$ git clone https://github.com/toro-io/bxn.git /opt/boxen/repo && cd /opt/boxen/repo

# Run the Bootstrap
$ ./script/boxen-bootstrap

# Run Boxen
# @param: --no-fde # skip filevault disk encryption
# @param: --debug  # see the behind the scene action
$ ./script/boxen
```

What You Get
---

- Homebrew
- Git
- Hub
- dnsmasq w/ .dev resolver for localhost
- rbenv
- Node.js 0.12.5
- Node.js 0.12.7
- Ruby 1.9.3
- Ruby 2.1.3
- ack
- Findutils
- GNU tar

Contributing Guidelines & FAQ
---

Please see the [Contributing Guidelines](CONTRIBUTING.md) or the
[Frequently Asked Questions](docs/faq.md) here.

Acknowledgements
---

[**Dwarf Shield Illustration**](http://roblfc1892.deviantart.com/art/dwarf-shield-67219251)
by [roblfc1892](http://roblfc1892.deviantart.com)
