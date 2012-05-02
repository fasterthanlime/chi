
import structs/[ArrayList, HashMap]


HValue: class {

    nil := static new()

    toString: func -> String {
        "%s" format(class name)
    }

    _: String {
        get {
            toString()
        }
    }

}

HInstruction: class {

    noop := static new()

    eval: func (scope: HScope) -> HScope {
        scope
    }

}

HBlock: class extends HInstruction {

    instructions := ArrayList<HInstruction> new()

    eval: func (scope: HScope) -> HScope {
        s := scope        
        instructions each (|i|
            s = i eval(s)
        )
        s
    }

}


HScope: class extends HValue {

    parent: HScope

    code := HBlock new()
    slots := HashMap<String, HValue> new()

    eval: func -> HScope {
        code eval(this)
    }

    lookup: func (name: String) -> HValue {
        if (slots contains?(name)) {
            slots get(name)
        } else if(parent) {
            parent lookup(name) 
        } else {
            HValue nil
        }
    }

    toString: func -> String {
        sb := Buffer new()
        sb append("(:")
        slots each(|k, v|
            sb append("%s: %s" format(k, v _))
        )
        sb append(")")
        sb toString()
    }

}


