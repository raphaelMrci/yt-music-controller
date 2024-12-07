-- Function to ensure Arc is fully running with a timeout
on ensureArcIsRunning()
    log "Checking if Arc is running..."
    tell application "System Events"
        set arcIsRunning to (name of application processes) contains "Arc"
    end tell

    if not arcIsRunning then
        log "Arc is not running. Launching Arc..."
        tell application "Arc" to activate

        -- Wait for Arc to appear in the process list with a timeout
        set timeoutCounter to 0
        tell application "System Events"
            repeat until (name of application processes) contains "Arc"
                delay 0.1 -- Poll every 0.1 seconds
                set timeoutCounter to timeoutCounter + 1
                if timeoutCounter > 100 then -- 10 seconds timeout
                    error "Arc did not start within the timeout period."
                end if
            end repeat
        end tell
        log "Arc has started successfully."
        delay 1 -- Short delay for Arc to fully initialize
    else
        log "Arc is already running."
    end if
end ensureArcIsRunning

-- Ensure Arc is active and brought to the front
on bringArcToFront()
    log "Bringing Arc to the foreground..."
    tell application "Arc" to activate
    tell application "System Events"
        repeat until (name of first application process whose frontmost is true) is "Arc"
            set frontmost of application process "Arc" to true
            delay 0.1 -- Short wait for the system to switch
        end repeat
    end tell
    log "Arc is now in the foreground."
end bringArcToFront

-- Main Script Execution
ensureArcIsRunning()
bringArcToFront()
