# go-ethereum-cross

Repository containing Docker files for cross-compilation of the
Ethereum go client (geth).  This is trivial, due to Péter Szilágyi's
excellent work on [xgo](https://github.com/karalabe/xgo/).

Used as part of [doublethinkco](http://doublethink.co)'s work
to bring Ethereum to mobile/wearable Linux platforms for the benefit
of the whole Ethereum community, current and future.

It is released as free software under the
[GPLv2 license](https://github.com/doublethinkco/webthree-umbrella-cross/blob/master/LICENSE.txt).

See [Porting Ethereum to Mobile Linux](http://doublethink.co/2015/09/22/porting-ethereum-to-mobile-linux/)
blog for an overview of our efforts.

# How to use it

Clone this repo and build and run [Dockerfile](https://github.com/doublethinkco/go-ethereum-cross/blob/master/Dockerfile):

    $ git clone https://github.com/doublethinkco/go-ethereum-cross.git
    $ cd go-ethereum-cross
    $ sudo docker build .

That generates a Docker *image*, which is not the same as a Docker
*container*.  Docker *images* are immutable binary images, which are
analogous to VM snapshots.  Docker *containers* are particular instances
of those images.  To get an instance of that newly created image running
you need to do:

    $ sudo docker run -i -t HASH_OF_IMAGE /bin/bash

In the shell for that container you will see the HASH for the container
instance.  That container will contain the generated geth binaries,
which you can copy out to the host machine with the following command
from another shell instance on your host machine.  Your "docker run"
*must* still be running for this copy step to work.    If somebody who
has more Docker experience knows how to streamline this experience,
please speak up!

    $ sudo docker cp HASH_OF_CONTAINER:/FILENAME ~/

Then you can "exit" the "docker run" session, and stop that Docker
container running.   It has served its purpose.

# Platform status

| Platform     | Native        | Cross   |
| -------------|---------------|---------|
| Android      | -             | Working |
| iOS          | -             | Working |
| Tizen        | -             | [TODO #1](http://github.com/doublethinkco/go-ethereum-cross/issues/1) |
| Sailfish     | [TODO #4](http://github.com/doublethinkco/go-ethereum-cross/issues/4) | [TODO #2](http://github.com/doublethinkco/go-ethereum-cross/issues/2) |
| Ubuntu Phone | [TODO #5](http://github.com/doublethinkco/go-ethereum-cross/issues/5) | [TODO #3](http://github.com/doublethinkco/go-ethereum-cross/issues/3) |


Copyright (c) 2015 Kitsilano Software Inc
