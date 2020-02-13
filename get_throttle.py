#!/usr/bin/env python3

import re
import subprocess
from datetime import datetime

bitmap = {
        0: 'Under-voltage detected',
        1: 'ARM frequency capped',
        2: 'Currently throttled',
        3: 'Soft temperature limit active',
        16:'Under-voltage has occurred',
        17:'Arm frequency capped has occurred',
        18:'Throttling has occurred',
        19:'Soft temperature limit has occurred',
}

result = subprocess.run(['vcgencmd', 'get_throttled'], stdout=subprocess.PIPE).stdout.decode('utf-8')
result = int(re.match('.*=0x(.*)', result).group(1), 16)

throttle_codes = tuple(i for i in bitmap if result & (1 << i))

if throttle_codes:
    with open('/home/pi/throttle.log', 'a') as f:
        for c in throttle_codes:
            f.write(' '.join((str(datetime.now()), str(c), bitmap[c])))
            f.write('\n')

