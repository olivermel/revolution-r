#!/usr/bin/env bash
sudo yum -y groupinstall 'Development Tools'
sudo yum -y install ed cairo-devel tk-devel gcc-objc readline-devel libtiff-devel ncurses-devel pango-devel texinfo libicu libjpeg*-devel ghostscript-fonts libSM-devel libicu-devel libXmu-devel bzip2-devel tree vim

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

if [ "$SCRIPTPATH" = "/tmp" ] ; then
    SCRIPTPATH=/vagrant
fi

mkdir -p $HOME/rpmbuild/{BUILD,RPMS,SOURCES,SRPMS}
ln -sf $SCRIPTPATH/SPECS $HOME/rpmbuild/SPECS
echo '%_topdir '$HOME'/rpmbuild' > $HOME/.rpmmacros

# Get Revolution R files
wget https://s3.amazonaws.com/new-rre-linux/compile_cran_r.sh -q
tar -zcvf compile_cran_r.tar.gz compile_cran_r.sh
cp compile_cran_r.tar.gz  $HOME/rpmbuild/SOURCES/
wget https://s3.amazonaws.com/new-rre-linux/revolution-r-connector-7.4.0-rhel6.tar.gz -P $HOME/rpmbuild/SOURCES/ -q
wget https://s3.amazonaws.com/new-rre-linux/revolution-r-enterprise-7.4.0-rhel6.tar.gz -P $HOME/rpmbuild/SOURCES/ -q ]
