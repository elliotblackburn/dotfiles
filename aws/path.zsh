# Add Python to PATH for Elasticbeanstalk CLI
export PATH=~/Library/Python/2.7/bin:$PATH
export PATH=~/Library/Python/3.7/bin:$PATH

PATH="/Users/elliotblackburn/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/elliotblackburn/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/elliotblackburn/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/elliotblackburn/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/elliotblackburn/perl5"; export PERL_MM_OPT;

# Python with homebrew
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
