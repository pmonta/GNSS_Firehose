#!/usr/bin/python

import firehose_hw
import sys

mac_addr = sys.argv[1]
interface = sys.argv[2]

f = firehose_hw.firehose(interface=interface, mac_addr=mac_addr)

v = f.version()
sys.stdout.write('firmware version: %d\n' % v)
