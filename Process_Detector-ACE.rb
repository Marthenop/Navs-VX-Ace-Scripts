=begin
Process Detector 1.0
-------------------
This was a fun one to make. I wanted to see if it was possible to detect if obs
was running so a vx ace game could mess with the player. (Though you could edit
this so it can detect any program.)

To run the script, all you have to do is call "Proclist.get" followed by 
"Proclist.set".
A switch will be turned on if the desired programs are detected. 
(Both can be configured.)
-------------------
I personally don't care if you use this for paid/free projects as this was made 
for fun, all I ask for is proper crediting. -NaV
=end

class Proclist
  
def self.get
  
  switch=6
  proc="Game.exe"
  
##################
  
  File.open(ENV['APPDATA']+"\\list.vbs", 'w') do |f|#Note: ENV['APPDATA'] is Ruby's way of using the Windows enviromental variables. (If you type %appdata% into the file explorer, you'll get the same result!) Also using this folder bc the point is to be sneaky about this.
    f.write("Set wShell = CreateObject (\"Wscript.Shell\")\nwShell.Run \"cmd /c tasklist >%appdata%\\list.txt\", 0\nWScript.Quit")#While I could write line by line, \n is a much neater way of doing a newline in our file.
  end
  system('wscript.exe %appdata%\\list.vbs')#Ah the system call, I think without specifying the folder it defaults to "C:\Windows\System32". In theory I might be able to use "%x|COMMAND|", but that didn't work in testing.
  File.delete(ENV['APPDATA']+'\\list.vbs')
   
  sleep 0.5 #Need to do this bc the system call takes about that many seconds to output list.txt
  
  f = File.open(ENV['APPDATA']+"\\list.txt", 'r')
  l = f.readlines
  f.close
  l.keep_if{|x| x.include?(proc)}
  if l.length > 0
    $game_switches[switch]=true
  end
  File.delete(ENV['APPDATA']+'\\list.txt')
end
end