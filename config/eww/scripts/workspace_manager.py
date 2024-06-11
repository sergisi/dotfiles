import json
import fileinput
import dataclasses as dto
import collections

import unittest

Workspace = dict[str, str]


@dto.dataclass
class Window:
    classname: str
    workspace: int
    id: str


@dto.dataclass
class State:
    active_window: str | None
    active_workspace: int | None
    workspaces: dict[int, "Workspace"]
    windows: dict[str, Window]


def parse_parameters(func):
    def f(params: str, state: State):
        return func(*params.split(","), state=state)

    return f


def open_window(id, work, classname, _, state: State):
    work = int(work)
    win = Window(classname=classname, workspace=work, id=id)
    state.workspaces[work][id] = classname
    state.windows[id] = win
    return state


def workspace(work, state: State):
    state.active_workspace = int(work)
    return state


def create_workspace(work, state: State):
    state.workspaces[int(work)] = dict()
    return state


def destroy_workspace(work, state: State):
    del state.workspaces[int(work)]
    return state


def move_window(id, work, state: State):
    work = int(work)
    del state.workspaces[state.windows[id].workspace][id]
    state.windows[id].workspace = work
    state.workspaces[work][id] = state.windows[id].classname
    return state


def active_window(id, state: State):
    if id == ",":
        state.active_window = None
    else:
        state.active_window = id
    return state


def from_id(id_raw: str):
    return id_raw[2:]


def state(json_raw, _: State):
    as_dict = json.loads(json_raw)
    windows = {}
    workspaces = collections.defaultdict(dict)
    for window_raw in as_dict:
        win = Window(
            classname=window_raw["class"],
            workspace=window_raw["workspace"],
            id=from_id(window_raw["id"]),
        )
        windows[win.id] = win
        workspaces[win.workspace][win.id] = win.classname
    return State(
        active_window=None,
        workspaces=dict(workspaces),
        windows=windows,
        active_workspace=None,
    )


commands = {
    "openwindow": parse_parameters(open_window),
    "workspace": parse_parameters(workspace),
    "createworkspace": parse_parameters(create_workspace),
    "destroyworkspace": parse_parameters(destroy_workspace),
    "movewindow": parse_parameters(move_window),
    "activewindowv2": active_window,
    "state": state,
}


def command():
    state = State(None, {}, {}, None)
    for rline in fileinput.input():
        line = rline.rstrip()
        params = line.split(">>")
        if params[0] in commands:
            state = commands[params[0]](params[1], state)
            print(json.dumps(dto.asdict(state)), flush=True)
            # print(json.dumps({k:[state.workspaces[k][k2] for k2 in state.workspaces[k]] for k in state.workspaces}),
            #   flush=True)


class TestFunctions(unittest.TestCase):
    def test_state_creation(self):
        state = State(None, {}, {}, None)
        state = commands["state"](
            '[{"id":"0x5591d0eaad40","class":"firefox","workspace":3},{"id":"0x5591d0ea26a0","class":"kitty","workspace":1},{"id":"0x5591d0ec2750","class":"kitty","workspace":5},{"id":"0x5591d0ed14b0","class":"kitty","workspace":2},{"id":"0x5591d0edf120","class":"kitty","workspace":2}]',
            state,
        )
        expected = State(
            active_window=None,
            active_workspace=None,
            workspaces={
                3: {"5591d0eaad40": "firefox"},
                1: {"5591d0ea26a0": "kitty"},
                5: {"5591d0ec2750": "kitty"},
                2: {"5591d0ed14b0": "kitty", "5591d0edf120": "kitty"},
            },
            windows={
                "5591d0eaad40": Window(
                    classname="firefox", workspace=3, id="5591d0eaad40"
                ),
                "5591d0ea26a0": Window(
                    classname="kitty", workspace=1, id="5591d0ea26a0"
                ),
                "5591d0ec2750": Window(
                    classname="kitty", workspace=5, id="5591d0ec2750"
                ),
                "5591d0ed14b0": Window(
                    classname="kitty", workspace=2, id="5591d0ed14b0"
                ),
                "5591d0edf120": Window(
                    classname="kitty", workspace=2, id="5591d0edf120"
                ),
            },
        )
        self.assertEqual(expected, state)
        state = commands["activewindowv2"]("5591d0ed14b0", state)
        self.assertEqual("5591d0ed14b0", state.active_window)

    def test_asdict(self):
        expected = State(
            active_window=None,
            active_workspace=None,
            workspaces={
                3: {"5591d0eaad40": "firefox"},
                1: {"5591d0ea26a0": "kitty"},
                5: {"5591d0ec2750": "kitty"},
                2: {"5591d0ed14b0": "kitty", "5591d0edf120": "kitty"},
            },
            windows={
                "5591d0eaad40": Window(
                    classname="firefox", workspace=3, id="5591d0eaad40"
                ),
                "5591d0ea26a0": Window(
                    classname="kitty", workspace=1, id="5591d0ea26a0"
                ),
                "5591d0ec2750": Window(
                    classname="kitty", workspace=5, id="5591d0ec2750"
                ),
                "5591d0ed14b0": Window(
                    classname="kitty", workspace=2, id="5591d0ed14b0"
                ),
                "5591d0edf120": Window(
                    classname="kitty", workspace=2, id="5591d0edf120"
                ),
            },
        )
        dto.asdict(expected)

    def test_active_window(self):
        state = State(None, {}, {}, None)
        state = commands["activewindowv2"]("asdfasdf", state)
        self.assertEqual("asdfasdf", state.active_window)
        state = commands["activewindowv2"](
            ",", state
        )  # when no one is to focus it inputs this.
        self.assertEqual(None, state.active_window)


# main = unittest.main
main = command

if __name__ == "__main__":
    main()
