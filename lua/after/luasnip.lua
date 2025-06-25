local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local r = ls.restore_node
local d = ls.dynamic_node
local extras = require("luasnip.extras")
local l = extras.lambda
local fmt = require("luasnip.extras.fmt").fmt
local postfix = require("luasnip.extras.postfix").postfix

local C_TEMPLATE_SOURCE_CODE = [[
#define self ((p<b>_t)super)
typedef struct <a>_s
{
    object_t  super;
} <a>_t;

]]

local C_TEMPLATE_HEADER_CODE = [[
#ifndef _<G>_H_
#define _<G>_H_
typedef struct <a>_s* p<b>_t;
typedef const struct <a>_s* p<b>Const_t;
#define <b>Cast(self_) ((p<b>_t)
p<b>_t  <b>_Create<n>(<p>);
#endif // _<G>_H_

]]

local C_UNION_STRUCT = [[
typedef union {
    uint8_t <a>[<n>];
    struct  {
        union {
            struct
            {
            }<f>;
            struct
            {
            }<f2>;
        };
    };

} <b>_t;
]]

local C_ENUM = [[
typedef enum {
    <V>,
    <B>_COUNT,
} e<b>_t;
]]

local C_STRUCT = [[
typedef struct <a>_s {
} <a>_t;

typedef struct <a>_s* p<b>_t;
typedef const struct <a>_s* p<b>Const_t;
]]

local C_BUFF_REP = [[
uint8_t <a>[<n>] = {<c>, <r>}
]]


local C_BUFF = [[
uint8_t <a>[<n>] = {<c>}
]]

local function repeatElement(args, parent, user_args)
    local rep = tonumber(args[1][1])
    if rep == nil then
        return "nil"
    end
    if rep ~= math.floor(rep) then
        return "not"
    end

    local result = ""
    for i = 1, rep - 2, 1 do
        result = result .. args[2][1] .. ", "
    end
    result = result .. args[2][1]

    return result
end

local function firstUpper(
    args,     -- text from i(2) in this example i.e. { { "456" } }
    parent,   -- parent snippet or parent node
    user_args -- user_args from opts.user_args
)
    local up = "" .. args[1][1] .. user_args .. ""
    return up:gsub("^%l", string.upper)
end

local function Upper(
    args,     -- text from i(2) in this example i.e. { { "456" } }
    parent,   -- parent snippet or parent node
    user_args -- user_args from opts.user_args
)
    local up = "" .. args[1][1] .. user_args .. ""
    return up:upper()
end

ls.add_snippets("all", {
    s(
        "rrr",
        c(1, {
            i(vim.fn.getreg("%")),
            t(vim.fn.getreg("/")),
        })
    ),
    postfix(".bk[", {
        l("[" .. l.POSTFIX_MATCH .. "]"),
    }),
    postfix(".bk{", {
        l("{" .. l.POSTFIX_MATCH .. "}"),
    }),
    postfix(".hex", {
        d(1, function(_, snip)
            local match = snip.env.POSTFIX_MATCH
            if not match then return sn(nil, t("nil")) end

            local hex = match:upper():gsub("(%x%x)", "0x%1, "):gsub(", $", "")
            return sn(nil, t(hex))
        end)
    }),
    postfix({ trig = "vec", match_pattern = [[[%w%.%_%-%"%']*$]] },
        { d(1, dynamic_postfix, {}, { user_args = { "\\vec{", "}" } }) },
        { condition = require("luasnip.util.util").yes }
    ),

})


ls.add_snippets("wiki", {
    s("LaDaaaaateKoliss", {
        extras.partial(os.date, " %d-%B-%Y(%x)"),
    }),
})

ls.add_snippets("c", {
    -- important! fmt does not return a snippet, it returns a table of nodes.
    s(
        "union_struct",
        fmt(C_UNION_STRUCT, {
            a = i(1, "full"),
            n = i(2, "10"),
            f = i(3, "field"),
            f2 = i(4, "field2"),
            b = i(5, "type"),
        }, {
            repeat_duplicates = true,
            delimiters = "<>",
        })
    ),
    s(
        "enum2",
        fmt(C_ENUM, {
            V = i(1, "FIELD"),
            b = i(2, "enumType"),
            B = f(Upper, { 2 }, { user_args = { "" } }),
        }, {
            repeat_duplicates = true,
            delimiters = "<>",
        })
    ),
    s(
        "struct2",
        fmt(C_STRUCT, {
            a = i(1, "typeStruct"),
            b = f(firstUpper, { 1 }, { user_args = { "" } }),
        }, {
            repeat_duplicates = true,
            delimiters = "<>",
        })
    ),
    s(
        "bufrep",
        fmt(C_BUFF_REP, {
            a = i(1, "buf"),
            n = i(2, "10"),
            c = i(3, "1"),
            r = f(repeatElement, { 2, 3 }, { user_args = { "" } }),
        }, {
            repeat_duplicates = true,
            delimiters = "<>",
        })
    ),
    s(
        "buf",
        fmt(C_BUFF, {
            a = i(1, "buf"),
            n = i(2, "10"),
            c = i(3, "1"),
        }, {
            repeat_duplicates = true,
            delimiters = "<>",
        })
    ),
    s("par_change", {
        c(1, {
            sn(nil, { t("("), r(1, "user_text"), t(")") }),
            sn(nil, { t("["), r(1, "user_text"), t("]") }),
            sn(nil, { t("{"), r(1, "user_text"), t("}") }),
        }),
    }, {
        stored = {
            -- key passed to restoreNodes.
            ["user_text"] = i(1, "default_text"),
        },
    }),
})
