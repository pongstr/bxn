# Personal Manifests

You may add complex stuff to your personal manifest like adding a detailed
customization of your personal settings like `dotfiles`, unofficial team
project installation or proof of concepts. If you would like to install apps
please consider adding a yaml config to `hiera/users/your-github-username.yaml`,
take the existing files in there as an example on how you can create your own
otherwise, knock yourselves up with `puppet syntax`, below is a quick guide on
how to write your personal manifest:

Per-user manifests live in `modules/people/manifests/$login.pp`, where
`$login` is a GitHub login. A simple user manifest example:

```puppet
class people::jbarnette {
  include emacs   # requires emacs module in Puppetfile
  include sparrow # requires sparrow module in Puppetfile

  $home     = "/Users/${::boxen_user}"
  $my       = "${home}/my"
  $dotfiles = "${my}/dotfiles"

  file { $my:
    ensure  => directory
  }

  repository { $dotfiles:
    source  => 'jbarnette/dotfiles',
    require => File[$my]
  }
}
```

Note that if your GitHub username contains dashes, you should replace them by underscores in both the manifest name and the class name.

## Projects

While you _can_ include projects one by one, sometimes you might just want
all of them.

You can do that easily with:

```
include projects::all
```

