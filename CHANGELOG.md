Bxn Team Mjolnir
===

## [1.1.0-RC-1] - Truth of a Madman
### OS X 10.11 Support
**Overview**
  - OS X 10.11 Compatibility
  - upgraded Gemfile with `boxen 2.8.0`
  - upgraded puppet-homebrew to `2.0.0`
  - upgraded puppet-python to `2.0.1`
  - added projects that runs in vms via vagrant
  - removed atom package installation from `manifests/site.pp` must be declared
    to personal puppet or hiera config.
  - upgraded mongodb to `3.0.6`, now using the team-maintained
    [puppet-mongodb](https://github.com/TORO-IO/puppet-mongodb)
  - `oh-my-zh` installed via Repository class

**Node.js Stuff**
  - Nodejs and Ruby global versions are now declared from `hiera/common.yaml`
  - node-v4.0.0 availability
  - Available nodejs versions: `0.12.7` and `4.0.0` we found that other
    versions previously installed are no longer necessary.

**Ruby Stuff**
  - Available ruby versions: `1.9.3` and `2.1.6` we found that other versions
    previously installed are no longer necessary.
  - bundler installation for all version
  - removed `gem bootstrap-sass`, bootstrap has switched from less to sass,
    we'll be using sass/scss as the default css preprocessor
  - deprecating `gem compass` in place of `libsass` + `sassc`


## [1.0.0] - 2015-09-04: Hammer of the Gods
### Initial Release
  - Now using Boxen `v3.11.0`, same version applied to [upstream repo](https://github.com/boxen/our-boxen).
  - Application puppets are maintained by the team [`puppet-*`](https://github.com/TORO-IO?utf8=✓&query=puppet-).
  - Boxen Web for automated installation. [branch](https://github.com/TORO-IO/bxn/tree/boxen-web) [9f174c6](https://github.com/TORO-IO/bxn/commit/9f174c6c436dad0bec379fcc51bc4aa362e0bff)
  - Boxen Web is restricted to Team Mjolnir only.

