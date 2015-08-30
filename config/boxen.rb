# This file will be loaded by config/basic early in a Boxen run. Use
# it to provide any custom code or behavior your Boxen setup requires.

# Change the prefix boxen is installed to.
ENV['BOXEN_HOME'] = '/opt/boxen'

# Change the repo boxen will use.
ENV['BOXEN_REPO_NAME'] = 'toro-io/bxn'

# Auto-report issues on failed runs
ENV["BOXEN_ISSUES_ENABLED"] = 'yes'

# Submit audit data to an arbitrary HTTP endpoint
# ENV["BOXEN_WEB_HOOK_URL"] = 'https://some-uri.com/boxen'
#
# Boxen binary packaging
# ENV["BOXEN_S3_ACCESS_KEY"] = ''
# ENV["BOXEN_S3_SECRET_KEY"] = ''
# ENV["BOXEN_S3_BUCKET"] = ''
#
# required for Github Enterprise
# ENV["BOXEN_GITHUB_ENTERPRISE_URL"] = 'https://github.yourdomain.com'

# required for Github Enterprise (defaults to "https://github.com/%s")
# ENV['BOXEN_REPO_URL_TEMPLATE'] = 'https://github.yourdomain.com/%s'