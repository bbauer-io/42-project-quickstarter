#!/bin/bash

#Set some variables for git:
EMAIL="bbauer@student.42.us.org"
USERNAME="bbauer-io"
LIBFT="https://github.com/bbauer-io/libft.git"
FT_PRINTF="https://github.com/bbauer-io/ft_printf.git"
GITHUB=""
VOGSPHERE=""

#Prompt for project name:
printf "What is the name of this project?\n"
read NAME

#Prompt for intened project save location:
printf "Where would you like to save this project? ( path from ~/ )\n"
read PREFIX

#Ask if user would like to initialize a Github repository:
printf "Would you like to initialize a Github repository?\n"
select CHOOSE in "Yes" "No"
do
	case $CHOOSE in
		Yes)
			printf "Please paste the Github repository URL:\n"
			read GITHUB
			break
			;;
		No)
			break
			;;
	esac
done

#Ask if user would like to initialize a Vogsphere repository:
printf "Would you like to initialize a Vogsphere repository?\n"
select CHOOSE in "Yes" "No"
do
	case $CHOOSE in
		Yes)
			printf "Please paste the Vogsphere repository URL:\n"
			read VOGSPHERE
			break
			;;
		No)
			break
			;;
	esac
done

echo "hold on to your butts..."

#Create files and directories:
printf "populating...\n"
DIR=~/$PREFIX/$NAME
mkdir -p $DIR/include $DIR/tests $DIR/libft $DIR/src $DIR/ft_printf
cp Makefile $DIR
cd $DIR
printf ":Stdheader\n:$\ndd\n:wq\n" > tmpvimcmd
vim -s tmpvimcmd include/$NAME.h
NAME_H=$NAME"_H"
printf "#ifndef $NAME_H\n# define $NAME_H\n\n# include \"libft.h\"\n# include \"ft_printf.h\"\n\n\n#endif\n" >> include/$NAME.h
vim -s tmpvimcmd src/$NAME.c
printf "#include \"../include/$NAME.h\"\n\n\n" >> src/$NAME.c
printf "tests\n" > .gitignore

#Configure a basic Makefile
vim -s tmpvimcmd Makefile
sed  -i.modified "s/__NAME_PLACEHOLDER__/$NAME/g" Makefile
mv Makefile.modified Makefile

rm tmpvimcmd

#Clone libft from my public repository
printf "cloning libft...\n"
git clone $LIBFT /tmp/libft #> /dev/null 2>&1
cp -R /tmp/libft/* libft/
mv $DIR/libft/libft.h $DIR/include/
rm -rf $DIR/libft/.git
rm -rf /tmp/libft

#Clone ft_printf from my public repository
printf "cloning ft_printf...\n"
git clone $FT_PRINTF /tmp/ft_printf #> /dev/null 2>&1
mv /tmp/ft_printf/src/* ft_printf/
mv /tmp/ft_printf/include/ft_printf.h $DIR/include/
rm -rf /tmp/ft_printf

#Configure basic git repository settings.
git init
git config user.email $EMAIL
git config user.name $USERNAME

#Initialize Github repo with origin URL if user added one.
if [ "$GITHUB" = "" ]; then
	printf "No Github repository to initialize.\n"
else
	printf "Adding Github repository...\n"
	git remote add origin $GITHUB
fi

#Initialize Vogsphere repo with origin URL if user added one.
if [ "$VOGSPHERE" = "" ]; then
	printf "No Vogsphere repository to initialize.\n"
else
	printf "Adding Vogsphere repository...\n"
	git remote add vogsphere $VOGSPHERE
fi

#Done!
printf "Finished! Directory for $NAME has been initialized at ~/$PREFIX/$NAME\n"
