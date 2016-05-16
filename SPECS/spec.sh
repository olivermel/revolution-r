############################
# Set global SPEC variables
############################
%global prefix /usr/local
%global bindir %{prefix}/bin
%define debug_package %{nil}

AutoReqProv: no

###############
# Set metadata
###############
Name: rev-r-enterprise
Version: 7.4.0
Release: 1
Summary: Revolution R Enterprise is the fastest, most cost effective enterprise-class big data big analytics platform available today.
Group: Development/Languagesrev
License: None
URL: http://www.revolutionanalytics.com/
Source0: compile_cran_r.tar.gz
Source1: Revolution-R-Connector-7.4.0-RHEL6.tar.gz
Source2: Revolution-R-Enterprise-7.4.0-RHEL6.tar.gz
Obsoletes: rev-r-enterprise < 7.4.0
Provides: rev-r-enterprise == 7.4.0

%description
Revolution R Enterprise is the fastest, most cost effective enterprise-class big data big analytics platform available today. Supporting a variety of big data statistics, predictive modeling and machine learning capabilities, Revolution R Enterprise is also 100% R. Revolution R Enterprise provides users with the best of both – cost-effective and fast big data analytics that are fully compatible with the R language, the de facto standard for modern analytics users.

Offering high-performance, scalable, enterprise-capable analytics, Revolution R Enterprise supports a variety of analytical capabilities including exploratory data analysis, model building and model deployment.

########################################################
# PREP and SETUP
# The prep directive removes existing build directory
# and extracts source code so we have a fresh
# code base.
########################################################
%prep
%setup -T -b 0 -c compile_cran_r -n compile_cran_r -q
%setup -T -b 1 -n rrconn -q
%setup -T -b 2 -n rrent -q

###########################################################
# BUILD
# The build directive does initial prep for building,
# then runs the configure script and then make to compile.
# Compiled code is placed in %{buildroot}
###########################################################
%build

# First Compile RevR's version of R itself
sh %{_builddir}/compile_cran_r/compile_cran_r.sh -d -p %{_builddir}%{prefix}/lib64 -y

# Now install the RevolutionR Connector
pushd %{_builddir}/rrconn
sh ./install_rr_conn.sh -p %{_builddir}%{prefix}/lib64/Revo-7.4/R-3.1.3 -e %{_builddir}%{prefix}/lib64/Revo-7.4 -y
popd

# And finally RevolutionR itself
pushd %{_builddir}/rrent
sh ./install_rr_ent.sh -p %{_builddir}%{prefix}/lib64/Revo-7.4/R-3.1.3 -e %{_builddir}%{prefix}/lib64/Revo-7.4 -y
popd

###########################################################
# INSTALL
# This directive is where the code is actually installed
# in the %{buildroot} folder in preparation for packaging.
###########################################################
%install

# Since the RevoR scripts both build and install, we now just copy over the installed files
mkdir -p %{buildroot}%{prefix}
cp -r %{_builddir}%{prefix}/* %{buildroot}%{prefix}/ 

###########################################################
# CLEAN
# This directive is for cleaning up post packaging, simply
# removes the buildroot directory in this case.
###########################################################
%clean
# Sanity check before removal of old buildroot files
#[ -d "%{buildroot}" -a "%{buildroot}" != "/" ] && rm -rf %{buildroot}

###########################################################
# INSTALLATION COMMANDS
###########################################################

##############################################################
# FILES
# The files directive must list all files that were installed
# so that they can be included in the package.
##############################################################
%files
%defattr(-,root,root,-)
%{prefix}

# This directive is for changes made post release.
%changelog
