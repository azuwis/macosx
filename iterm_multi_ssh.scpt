-- -*- Mode: AppleScript -*-

-- this script will prompt an input box, run ~/bin/get_host with the input as the
-- param to get a list of hosts, one host per line, then open multiple tabs in
-- iTerm and ssh all the hosts.

tell application "iTerm"
    activate

    -- get input
    set theReply to display dialog "Get hosts:" default answer "input here" with icon 1
    set input to text returned of theReply

    -- get hosts from shell script with the input
    set the_hosts to (do shell script "~/bin/get_host " & input)

    -- tell iTerm to ssh all hosts
    set myterm to (make new terminal)
    tell myterm
        set hosts to paragraphs of the_hosts
        repeat with nextLine in hosts
            if length of nextLine is greater than 0 then
                set mysession to (make new session at the end of sessions)
                tell mysession
                    set name to nextLine
                    exec command "ssh " & nextLine
                end tell
            end if
        end repeat
    end tell
end tell
