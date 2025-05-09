# DegeaAutopilotScripts
Collection of scripts to retrieve machine hash. Public repo

# How to run this script
- Requires USB stick

</br>
Run Get-PSDrive to look up all drives.
</br>

```powershell
Get-PSDrive
```
![alt text](https://github.com/Degea-AB/DegeaAutopilotScripts/blob/main/Images/get-psdrive.png "get-psdrive")

</br>
Note down the drive letter for your USB stick, in the example above it's D:. Browse to D: and run the dir command to view the file contents.
</br>

```powershell
cd D:
dir
```
![alt text](https://github.com/Degea-AB/DegeaAutopilotScripts/blob/main/Images/cd-and-dir.png "cd and dir")

</br>
Run the script by typing the below command. You can hit tab after typing a few letters to autocomplete.
</br>

```powershell
.\Get-HashForAutopilotOOBE.ps1
```

![alt text](https://github.com/Degea-AB/DegeaAutopilotScripts/blob/main/Images/runscript.png "run script")

</br>
A CSV file will be created on the USB stick with the serialnumber as name (<serialnumber.csv>). Make sure the file contains the hash, forward the file to Degea for import.
</br>
