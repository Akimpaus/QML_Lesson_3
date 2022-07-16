import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts

Window
{
    id: window
    width: 300
    height: 270
    visible: true
    title: qsTr("Hello World")
    color: Qt.rgba(0.5,0.5,0.7,1);

    Item
    {
        id: item_states
        state: "not_auth"
        states:
        [
            State
            {
                name: "not_auth"
            },
            State
            {
                name: "auth"
            },
            State
            {
                name: "searching"
                PropertyChanges { target: busy_timer; running: true }
            },
            State
            {
                name: "search_end"
                PropertyChanges { target: swipe_view; currentIndex: 3 }
            }
        ]

        transitions:
        [
            Transition
            {
                from: "not_auth"
                to: "auth"
                PropertyAnimation
                {
                    target: not_auth
                    property: "opacity"
                    duration: 500
                    from: 1
                    to: 0
                }
                onRunningChanged:
                {
                    if ((item_states.state != "not_auth") && (!running))
                    {
                        swipe_view.currentIndex = 1;
                    }
                }
            },

            Transition
            {
                from: "auth"
                to: "searching"
                ParallelAnimation
                {
                    PropertyAnimation
                    {
                        target: qury_field
                        property: "x"
                        duration: 500
                        from: qury_field.x
                        to: -window.width
                    }
                    PropertyAnimation
                    {
                        target: button_search
                        property: "x"
                        duration: 500
                        from: button_search.x
                        to: window.width
                    }
                }
                onRunningChanged:
                {
                    if ((item_states.state != "auth") && (!running))
                    {
                        swipe_view.currentIndex = 2;
                    }
                }
            },

            Transition
            {
                from: "searching"
                to: "search_end"
                PropertyAnimation
                {
                    target: search_end
                    property: "opacity"
                    duration: 700
                    from: 0
                    to: 1
                }
            }
        ]
    }

    StackLayout
    {
        id: swipe_view
        anchors.fill: parent



        Item
        {
            id: not_auth
            Column
            {
                anchors.centerIn: parent
                spacing: 10
                Column
                {
                    TextField
                    {
                        placeholderText: "Login"
                    }
                    TextField
                    {
                        placeholderText: "Password"
                        echoMode: TextField.Password
                    }
                }

                Button
                {
                    width: parent.width
                    text: "Sign up"
                    onClicked:
                    {
                        item_states.state = "auth"
                    }
                }
            }
        }


        Item
        {
            id: auth
            Row
            {
                anchors.centerIn: parent
                TextField
                {
                    id: qury_field
                    placeholderText: "Query"
                }
                Button
                {
                    id: button_search
                    text: "Search"
                    onClicked:
                    {
                        item_states.state = "searching"
                    }
                }
            }
        }


        BusyIndicator
        {
            id: searching
            Timer
            {
                id: busy_timer
                interval: 3000
                onTriggered:
                {
                    running: false
                    item_states.state = "search_end"
                }
            }
        }


        Item
        {
            id: search_end
            Text
            {
                anchors.centerIn: parent
                text: "Not found"
                font.pointSize: 20
            }
        }

    }


}
