# Always dispatch to the Apple ssh implementation.
function ssh --wraps ssh
    /usr/bin/ssh $argv
end

function ssh-add --wraps ssh-add
    /usr/bin/ssh-add $argv
end

function ssh-agent --wraps ssh-agent
    /usr/bin/ssh-agent $argv
end

function ssh-copy-id --wraps ssh-copy-id
    /usr/bin/ssh-copy-id $argv
end

function ssh-keygen --wraps ssh-keygen
    /usr/bin/ssh-keygen $argv
end

function ssh-keyscan --wraps ssh-keyscan
    /usr/bin/ssh-keyscan $argv
end
