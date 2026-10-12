# Org keymaps

Keymaps for [org.nvim](https://github.com/xheisenbugx/org.nvim), configured in
[`lua/plugins/org.lua`](../lua/plugins/org.lua). Back to the [README](../README.md).

The prefix is `<leader>o` (`<Space>o`). `g?` in any org or agenda buffer lists the keys live
for that buffer, and which-key shows them as you type.

Org also ships Emacs bindings (`<C-c>…`, `<C-c><C-x>…`, `<C-c><C-v>…`) on top of the ones
below. They mirror Emacs `org-mode-map` one-for-one; `g?` lists them.

## Files

| Path | Purpose |
| --- | --- |
| `~/org/inbox/tasks.org` | Captured tasks and quick notes (`<leader>oc`, `<leader>oq`) |
| `~/org/inbox/` | New roam notes, until processed |
| `~/org/journal/` | Daily notes, one `YYYY-MM-DD.org` per day; weekly reviews land here too |
| `~/org/notes/` | Processed roam notes, one `slug.org` per node |
| `~/org/archive/` | Archived subtrees |

Agenda and roam read `inbox/`, `journal/` and `notes/`. Top-level files and `archive/` are
left out.

## Workflow

1. **Capture**: tasks go to `inbox/tasks.org` (`<leader>oc`, `<leader>oq`), new notes to
   `inbox/` (`<leader>omf` with a new title), the day's log to the daily note (`<leader>omj`).
2. **Process** (during the weekly review or whenever):
   - Tasks: `<leader>or` moves them under a note or into a daily note.
   - Notes: rename the file from `inbox/` to `notes/` in the explorer (`\`). Links use IDs, so
     they survive the move; run `:Org roam_db_sync` if you moved files outside Neovim.
   - Part of a note worth its own: `<leader>omx` extracts it into `notes/`.
3. **Review** weekly with `<leader>oW`. Finishing (`F`) captures the summary and your
   reflection answers into that day's daily note; confirm with `<leader>ow`.

## Global

Available from any buffer.

| Key | Action |
| --- | --- |
| `<leader>oa` | Agenda |
| `<leader>oc` | Capture (`t` task, `n` note → `inbox/tasks.org`) |
| `<leader>oq` | Quick add a task to `inbox/tasks.org` (`Call Bob fri 3pm #work !A`) |
| `<leader>og` | Go to a heading in any org file |
| `<leader>ols` | Store link to the current location |
| `<leader>oxj` / `<leader>oxo` / `<leader>oxq` | Clock: go to / out / cancel |
| `<leader>oW` | Weekly review (see [below](#weekly-review)) |
| `<leader>oVt` / `<leader>oVh` / `<leader>oVs` | Views: timeline / heatmap / sidebar |

## Roam (`<leader>om`)

| Key | Action |
| --- | --- |
| `<leader>omf` | Find a node; typing a missing title creates it in `inbox/` |
| `<leader>omi` | Insert a link to a node (Visual: selection becomes the title) |
| `<leader>omc` | Capture into a node |
| `<leader>oml` | Toggle the backlinks window |
| `<leader>omr` | Visit a random node |
| `<leader>omg` | Node graph (needs Graphviz `dot`) |

In an org buffer, acting on the node at point:

| Key | Action |
| --- | --- |
| `<leader>oma` | Add alias |
| `<leader>omR` | Add ref (URL / citation key) |
| `<leader>omt` | Add tag |
| `<leader>omx` | Extract subtree into a new note in `notes/` |
| `<leader>omw` | Refile subtree under another node |

A file or heading is a node only once it has an `:ID:` — `<leader>olI` adds one to an
existing note.

### Daily notes (`<leader>omd`)

| Key | Action |
| --- | --- |
| `<leader>omdt` | Today's note |
| `<leader>omdy` / `<leader>omdT` | Yesterday's / tomorrow's note (a count moves N days) |
| `<leader>omdd` | Pick a date from the calendar |
| `<leader>omdn` / `<leader>omdp` | Next / previous existing note |
| `<leader>omj` | Capture an entry into today's note |

## Weekly review

`<leader>oW` opens a float that steps through: empty the inbox (`inbox/tasks.org`), stuck
projects, `WAITING`, overdue, the next two weeks, `SOMEDAY`, time clocked last week and three
reflection questions. Progress is saved after every change, so you can quit and resume.

| Key | Action |
| --- | --- |
| `n` / `]]` | Next step |
| `p` / `[[` | Previous step |
| `<CR>` | Open the entry (on a question: answer it) |
| `r` | Refile the entry |
| `t` | Change TODO state |
| `s` / `S` | Schedule / deadline |
| `d` | Delete the entry (asks first) |
| `x` | Skip the entry |
| `i` | Add a note |
| `R` | Refresh |
| `F` | Finish: capture the summary into today's daily note |
| `q` / `<Esc>` | Quit (resume later with `<leader>oW`) |

## Org buffers

### Visibility & navigation

| Key | Action |
| --- | --- |
| `<Tab>` / `<S-Tab>` | Cycle subtree / whole buffer |
| `]]` / `[[` | Next / previous heading |
| `][` / `[]` | Next / previous sibling |
| `g{` | Parent heading |
| `<leader>o.` | Jump to a heading in this buffer |
| `gO` | Outline (document symbols) |
| `<leader>ohn` / `<leader>onb` / `<leader>one` | Narrow to subtree / block / element |
| `<leader>o/` | Sparse tree (search) |
| `ih` / `ah` | Text object: inner / around heading |
| `ir` / `ar` | Text object: inner / around subtree |

### Structure

| Key | Action |
| --- | --- |
| `<M-CR>` / `<M-S-CR>` | New heading or item / new TODO (Normal and Insert) |
| `<leader>oih` / `<leader>oit` / `<leader>ois` | Insert heading / TODO heading / subheading |
| `<leader>oid` / `<leader>oib` / `<leader>oif` | Insert drawer / block template / footnote |
| `<leader>oi@` | Insert citation |
| `<<` / `>>` | Promote / demote heading |
| `<s` / `>s` | Promote / demote subtree |
| `<M-h>` / `<M-l>` | Promote / demote (heading, item or table column) |
| `<M-k>` / `<M-j>` | Move subtree, item or table row up / down |
| `<M-H>` / `<M-L>` / `<M-K>` / `<M-J>` | Shift-meta variants (subtree promote/demote, table insert/delete) |
| `<leader>oK` / `<leader>oJ` | Move subtree up / down |
| `<leader>ohy` / `<leader>ohd` / `<leader>ohp` | Copy / cut / paste subtree |
| `<leader>ohc` | Clone subtree with shifted dates |
| `<leader>ohs` | Sort entries |
| `<leader>ohC` / `<leader>ohA` | Toggle COMMENT / ARCHIVE tag |
| `<leader>o*` / `<leader>o-` | Toggle heading / list item |
| `<leader>ohb` | Cycle list bullet style |
| `<leader>oE` | Emphasis (bold, italic, …) |
| `<leader>ov` | Select element |
| `p` / `P` | Paste, adjusting pasted subtree levels |

### TODO, priority, tags, properties

| Key | Action |
| --- | --- |
| `cit` / `ciT` | Next / previous TODO state |
| `<leader>oS` | Pick a TODO state |
| `<S-Left>` / `<S-Right>` | Cycle TODO state (or timestamp / item at point) |
| `<S-Up>` / `<S-Down>` | Cycle priority (or timestamp / item at point) |
| `<C-a>` / `<C-x>` | Increment / decrement timestamp, priority or number |
| `<leader>o,` | Set priority |
| `<leader>ot` | Set tags |
| `<leader>op` / `<leader>oP` | Set / delete property |
| `<leader>olI` | Create an `:ID:` |

### Dates

| Key | Action |
| --- | --- |
| `<leader>os` / `<leader>od` | Schedule / deadline |
| `<leader>oi.` / `<leader>oi!` | Insert active / inactive timestamp |

### Lists & checkboxes

| Key | Action |
| --- | --- |
| `<leader>o<Space>` | Toggle checkbox (`<C-Space>` is the tmux prefix) |
| `<leader>o#` | Update `[n/m]` statistics cookies |

### Links

| Key | Action |
| --- | --- |
| `<CR>` / `gx` / `<leader>oo` | Open link, timestamp or citation at point |
| `<leader>oli` | Insert link |
| `<leader>ols` | Store link |
| `<leader>olL` / `<leader>olA` | Insert last stored / all stored links |
| `<leader>oln` / `<leader>olp` | Next / previous link |
| `<leader>olt` | Toggle link display (description vs raw) |
| `<leader>olg` / `<leader>oly` | Go to ID / copy ID |

### Context, refile, archive, export

| Key | Action |
| --- | --- |
| `<C-c><C-c>` / `<leader>o<CR>` | Context action (toggle checkbox, recalc table, run block, …) |
| `<leader>or` / `<leader>oR` | Refile / refile a copy |
| `<leader>o$` | Archive subtree to `archive/` |
| `<leader>oA` | Attachments |
| `<leader>oe` | Export |
| `<leader>o'` | Edit special (source block, table formula) in its own buffer |

### Clock, effort, dynamic blocks

| Key | Action |
| --- | --- |
| `<leader>oxi` / `<leader>oxo` / `<leader>oxq` | Clock in / out / cancel |
| `<leader>oxj` | Go to the running clock |
| `<leader>oxe` / `<leader>oxE` / `<leader>oxm` | Set / increase / modify effort |
| `<leader>oxz` | Resolve dangling clocks |
| `<leader>oxr` / `<leader>oxd` | Clock report / show clocked times |
| `<leader>oxu` / `<leader>oxU` | Update dynamic block / all blocks |
| `<leader>oC` | Column view |
| `<leader>oxv` / `<leader>oxV` | Preview linked images / refresh |
| `<leader>oxl` | LaTeX preview |

### Tables (`<leader>oT`)

| Key | Action |
| --- | --- |
| `<leader>oTc` | Create table |
| `<leader>oT-` | Insert horizontal rule |
| `<leader>oTr` / `<leader>oTR` | Insert / delete row |
| `<leader>oTi` / `<leader>oTI` | Insert / delete column |
| `<leader>oTs` / `<leader>oTt` | Sort / transpose |
| `<leader>oTf` | Recalculate formulas |
| `<leader>oT#` | Rotate recalc marks |
| `<S-CR>` | Copy field down (Normal and Insert) |
| `<Tab>` / `<S-Tab>` / `<CR>` | Insert mode: next field / previous field / next row |

### Source blocks (`<leader>ob`)

| Key | Action |
| --- | --- |
| `<leader>obe` / `<leader>obs` / `<leader>obb` | Execute block / subtree / buffer |
| `<leader>obt` / `<leader>obf` | Tangle / tangle file |
| `<leader>obk` | Remove result |
| `<leader>obn` / `<leader>obp` | Next / previous block |
| `<leader>obg` / `<leader>obr` / `<leader>obu` | Go to named block / named result / block head |
| `<leader>obo` | Open result |
| `<leader>obv` / `<leader>obI` / `<leader>obc` | Expand / info / check |
| `<leader>obj` | Insert header argument |
| `<leader>obd` / `<leader>obm` | Split block / select block |
| `<leader>obi` | Ingest into the library of Babel |
| `<leader>obl` / `<leader>obz` / `<leader>obZ` / `<leader>obK` | Session: load / switch / switch with code / kill |
| `<leader>oba` / `<leader>obh` / `<leader>obx` | SHA1 hash / describe bindings / key sequence |

## Capture & edit-special buffers

| Key | Capture | Edit special |
| --- | --- | --- |
| `<leader>ow` / `<C-c><C-c>` | Finish | — |
| `<leader>o'` / `<C-c>'` | — | Save and exit |
| `<leader>ok` / `<C-c><C-k>` | Abort | Abort |
| `<leader>or` / `<C-c><C-w>` | Refile instead of filing | — |
| `<leader>oe` / `<C-c><C-c>` | — | Send to `:session:` |

## Agenda

### Moving around

| Key | Action |
| --- | --- |
| `f` / `b` / `.` | Later / earlier / today |
| `gd` | Go to date |
| `vd` / `vw` / `vt` / `vm` / `vy` | Day / week / fortnight / month / year view |
| `v<Space>` | Reset view |
| `n` / `p` | Next / previous item |
| `<C-Down>` / `<C-Up>` | Next / previous block |
| `<Tab>` / `<CR>` | Go to entry (other window / this window) |
| `<Space>` / `<BS>` | Show entry / scroll it |
| `F` | Follow mode |
| `L` / `o` | Recenter / close other windows |
| `r` / `gr` | Refresh / refresh all |
| `q` / `Q` / `x` | Quit / quit and kill / exit |

### Editing entries

| Key | Action |
| --- | --- |
| `t` | Change TODO state |
| `,` / `+` / `-` | Set / raise / lower priority |
| `:` / `T` | Set / show tags |
| `s` / `d` | Schedule / deadline |
| `<S-Right>` / `<S-Left>` | Shift date a day later / earlier |
| `>` | Prompt for a new date |
| `I` / `O` / `X` / `J` | Clock in / out / cancel / go to clock |
| `e` | Set effort |
| `z` | Add note |
| `R` | Refile |
| `$` / `a` | Archive / archive with confirmation |
| `<C-k>` | Delete entry |
| `K` | Capture |
| `A` | Append another agenda view |
| `<C-x><C-s>` | Save all org buffers |
| `<C-_>` / `<C-/>` | Undo |

### Display modes

| Key | Action |
| --- | --- |
| `l` / `vL` | Log mode / log everything |
| `C` / `vR` | Clock report |
| `vc` | Clock check |
| `E` | Entry text |
| `va` / `vA` | Include archived trees / archive files |
| `v[` | Include inactive timestamps |
| `vG` | Time grid |
| `!` | Toggle deadlines |
| `D` / `i` | Toggle diary / add diary entry |
| `vh` | Toggle habits |
| `#` | Dim blocked tasks |

### Filters & bulk

| Key | Action |
| --- | --- |
| `/` | Filter (prompt) |
| `\` / `<` / `=` / `_` / `^` | Filter by tag / category / regexp / effort / top headline |
| `\|` | Remove all filters |
| `~` | Limit number of entries |
| `[` / `]` / `{` / `}` | Search view: add / subtract word or regexp |
| `m` / `u` / `U` | Mark / unmark / unmark all |
| `*` / `%` / `<M-m>` | Mark all / by regexp / toggle mark |
| `B` | Bulk action on marked entries |

### Calendar

| Key | Action |
| --- | --- |
| `c` | Calendar |
| `gC` | Convert date |
| `M` / `S` / `H` | Moon phases / sunrise and sunset / holidays |
| `?` | Show flagging note |
| `g?` | Help |
