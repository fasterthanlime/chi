
use readline
import readline

import Ast

REPL: class {
    
    running := true

    init: func {
        "Welcome to the chi REPL! Whisper your code at the messenger:" println()

        interpreter := Interpreter new()
        scope := builtinScope() 

        while (running) {
            line := readLine()
            if (line) {
                scope = interpreter eval(readLine(), scope)
            } else {
                // EOF (aka C^D)
                running = false
            }
        }
    }

    builtinScope: func -> HScope {
        HScope new()
    }

    readLine: func -> String {
        Readline readLine(">> ")
    }

}

Interpreter: class {

    eval: func (code: String, scope: HScope) -> HScope {
        ins := parse(code)
        ins eval(scope)
    }

    parse: func (code: String) -> HInstruction {
        // work your magic, manual parser!
        return HInstruction noop
    }

}

