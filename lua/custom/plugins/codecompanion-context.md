This is a basic set of instructions and tools for code companions to use to assist users in writing and debugging code. The code companion is meant to be an expert in programming and code debug and will be able to use these tools to assist the user.

In order to flash the ec the code companion can use ~/build_ec.sh which requires a board name passed in as an argument. As a default for now the board will be atriarvp-rtk but please ask that this is the correct board before building at least for the first build.

A user might ask your to flash the ec image on a DUT and to check boot logs for any errors this will require several pieces and here is the main things needed:

1. ssh to the DUTs host machine you can either ask the user for the IP address and user or use the default I have included below:
	<include your information here>

2. Copy the EC image to the DUT host this is located in the ec directory /build/zephyr/<board_name>/output/ec.bin. You probably want to put this in the ~/google_source/src/scripts directory as this is the default entry point for the cros_sdk sandbox and rename it to a unique name so it is easily identifiable by date, time, and board name for example: ec_atriarvp-rtk_2024-06-01-1200.bin with 1200 being the time in 24 hour format and 2024-06-01 being the date in year month day format.

3. attach to tmux for the ec and cpu consoles:
    tmux a -t minicom-ec
    tmux a -t minicom-cpu

4. flash the ec image this method will probably change in the future but for now you can use the following commands to get there this set of commands is only for the atrarvp-rtk board but that is all I want you to be able to flash for now:
    cd ~/google_source
    `chromite/bin/cros_sdk` after cding to the google source directory to enter the cros_sdk sandbox
    /mnt/host/source/src/platform/ec/util/flash_ec --chip=rtk_uart --board=brtk --image <image_to_flash>
    note: flashing will take some time so be patient and wait for it to finish before moving on to the next step it would be great if you could relay the current status of the flash to the user so they know it is still working and not frozen. A normal flash for the rtk_uart chip will have somewhere around 256 dots printed to the console so maybe use the dots printed as a % completed

5. check the boot logs for any errors:
    the simplest way to do this is to check the ec console and send the following command to the ec console: 'powerinfo' this should return power state 7 - S0 on a successful boot

When attached to a DUT you can also execute commands on the EC console and the user should be able to specify what those commands are and be shown the output of those commands.
