# How to prepare HIVEOS to mine XENBlocks

## Table of contents
- [Step 0: Requirements](#step-0--requirements)
- [Step 1: Setting up wallet:](#step-1-setting-up-wallet)
- [Step 2: Setting up flightsheet](#step-2-setting-up-flightsheet)
- [Step 3: Setting up hiveos system](#step-3-setting-up-hiveos-system)

[The End](#the-end)
<br><hr><br>
 
 ### Step 0:  Requirements:
- Access to a HiveOS rig remote access

### Step 1: Setting up wallet:

Add wallet <br>
![obraz](https://github.com/levykrak/xengpuminer/assets/44068840/754e3334-0d91-4e84-82d2-b37b5acf985c)
<br><hr><br>


### Step 2: Setting up flightsheet:

Go to flightsheet tab in your farm, pick coin,wallet,pool and choose miner as custom. Before Update, click "Setup Miner Config"<br>
![obraz](https://github.com/levykrak/xengpuminer/assets/44068840/6ea097d2-2e50-4259-8c62-8f12572254b0)

Put all informations for custom configuration<br>
<br>
```bash
https://github.com/levykrak/xengpuminer/raw/main/xengpuminer-0.1.tar.gz
```
Archive contains builded XENGPUminer from https://github.com/shanhaicoder/XENGPUMiner  and necessary scripts for hiveos from here https://github.com/minershive/hiveos-linux/blob/master/hive/miners/custom/README.md. You can also adjust "Extra config arguments:" for you specification.
<br>
In this case "-g 12" means numbers of GPUs 
<br>

![obraz](https://github.com/levykrak/xengpuminer/assets/44068840/539a9690-7ba2-4913-a83f-94621d577a1e)
<br><br>

Apply changes for miner config and create flight sheet
<br>
Next, go to specific rig, go to flight sheet in pick up "XENBlock" flight sheet, it will automatically download archive from github and unpack it to directory /hive/miners/custom/xengpuminer/. Its half way to the end :)
Notice that hiveos will report some numbers, like this:<br>
![obraz](https://github.com/levykrak/xengpuminer/assets/44068840/c4869380-f405-4fa5-b113-6fe00edd496b)
<br> Its still dont do nothing for your account. U need do next steps

<br><hr><br>

### Step 3: Setting up hiveos system:

Just execute this command:
```bash
add-apt-repository ppa:deadsnakes/ppa && apt update && apt upgrade -y && apt install python3-pip python3.8 ocl-icd-opencl-dev -y && cd /hive/miners/custom/xengpuminer/ && python3.8 -m pip install --upgrade pip && python3.8 -m pip install -U -r requirements.txt
```
And just click enter twice. 
It will install all needed dependencies<br>

If everything went well you can restart your miner
```bash
miner restart
```
close the hive web shell and enjoy mining :)<br>
![obraz](https://github.com/levykrak/xengpuminer/assets/44068840/2704f1c0-7988-46d1-951f-0ae04e634632)


<br>

### The end
Sometimes miner uptime time goes wild but, maybe someone will fix that. 

levykrak alias aklimczyk

