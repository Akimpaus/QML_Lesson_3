import QtQuick 2.12
import QtQuick.Controls 2.12

Window
{
    visible: true
    width: 800
    height: 600
    Item
    {
        height: 450
        width: 330
        ListModel
        {
            id: books

            ListElement
            {
                group: "Детектив"
                name: "Aзазель"
                author: "Борис Акунин"
            }
            ListElement
            {
                group: "Мистика"
                name: "Дракула"
                author: "Брэм Стокер"
            }
            ListElement
            {
                group: "Триллер"
                name: "Молчание ягнят."
                author: "Томас Харрис"
            }
            ListElement
            {
                group: "Приключения"
                name: "Остров сокровищ"
                author: "Робер Льюис"
            }
        }

        ListView
        {
            id: list
            anchors.fill: parent
            model: books
            spacing: 1

            header: Rectangle
            {
                width: parent.width
                height: 20
                color: "darkblue"
                Text
                {
                    anchors.centerIn: parent
                    text: "My book collection."
                    color: "white"
                }
            }

            footer: Rectangle
            {
                width: parent.width
                height: 20
                color: "darkgreen"
                Text
                {
                    anchors.centerIn: parent
                    text: "Akim Kleimenov"
                    color: "white"
                }
            }

            section.delegate: Rectangle
            {
                width: parent.width
                height: 20
                color: "lightblue"
                Text
                {
                    anchors.centerIn: parent
                    text: section
                    color: "darkblue"
                    font.weight: Font.Bold
                }
            }

            section.property: "group"

            delegate: Rectangle
            {
                width: list.width
                height: 35
                radius: 3
                border.width: 1
                border.color: "darkgray"
                color: "lightgray"

                Column
                {
                    anchors.fill: parent
                    Row
                    {
                        spacing: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text
                        {
                            text: "Название:"
                            font.weight: Font.Bold
                        }
                        Text
                        {
                            text: name
                        }
                    }
                    Row
                    {
                        spacing: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text
                        {
                            text: "Автор:"
                            font.weight: Font.Bold
                        }
                        Text
                        {
                            text: author
                        }
                    }
                }
            }
        }
    }
}
