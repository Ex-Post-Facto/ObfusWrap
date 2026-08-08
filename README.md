# ObfusWrap

*Wrapper for Bashfuscator*

Bashfuscator is a handy tool for obfuscating Bash payloads. To make it even more 
convenient to use I wrote this wrapper for it. The menu will ask you
whether you want to obfuscate a file(shell script) or input your own commands.

There are three modes built in ObfusWrap.

  1. Default
  2. Random
  3. Custom

Default obfuscation will obfuscate your  commands or shell script with the 
following mutators in order of appearence.

```
token/forcode 
encode/xor_non_null 
compress/gzip
```

Depending on the target box and security context of the process/user that's executing
an obfuscated command or script, some binaries used to run said script
or command may not be available.

Which is why i added the option to choose the mutators yourself, or have a random
combination of mutators obfuscate your payload.

If you don't have Bashfuscator installed you can clone it

```bash
git clone https://github.com/Bashfuscator/Bashfuscator
cd Bashfuscator
python3 setup.py install --user
```

For more information on Bashfuscator click ('here')'[https://github.com/Bashfuscator/Bashfuscator']
to be taken to the original project's Github page.
