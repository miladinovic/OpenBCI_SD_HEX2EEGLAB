# OpenBCI_SD_HEX2EEGLAB
A Matlab script that transforms hexadecimal data files written on SD card to GDF + EEGLAB import

For conversion run:
SDhex2EEGLAB

Warning(s):
- For now works only with 16 + 3 Auxiliary channels (Cyton+Daisy)!
- Gain on all channels has been set to x24

To improve:
- Reading line by line textual file is very slow in matlab
