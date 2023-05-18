%dw 2.0
output application/json skipNullOn="everywhere"
fun processPayloadForWhiteSpace(data, fn) = (
    data match {
        case is Object -> data mapObject { ( $$ ): processPayloadForWhiteSpace( $, fn ) } 
        case is Array -> data map processPayloadForWhiteSpace($,fn)
        else -> fn(data)
    }
)
fun trimWhiteSpace(c) = if(c is String) trim(c) else  c
---
processPayloadForWhiteSpace(read(payload.^raw,'application/csv',{separator: "|"}),trimWhiteSpace)
