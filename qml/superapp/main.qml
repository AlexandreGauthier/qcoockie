import QtQuick 2.0

Rectangle {
    property double cookies: parseInt(settings.getValue("cookies", 15))
    property double bps: parseInt(settings.getValue("bps", 0))
    property int selectedItemNumber: -1

    id: base
    width: 800
    height: 600
    color: "orange"

    FontLoader { id: fontRibeye; source: "Ribeye-Regular.ttf" }

    Component.onCompleted: {
        counterText.cookieUnit = getUnit(bps)
    }

    Component.onDestruction: {
        settings.setValue("cookies", cookies);
        settings.setValue("bps", bps);
    }

    function getUnit(n) {
        if (n < 1000)
            return "thousand";
        if (n < 1000000)
            return " million ";
        if (n < 1000000000)
            return " billion ";
        if (n < 1000000000000)
            return " trillion ";
        if (n < 1000000000000000)
            return " quadrillion ";
        if (n < 1000000000000000000)
            return " quintillion ";
        return " sextillion";
    }

    function getDiv(n) {
        if (n < 1000)
            return 1000;
        if (n < 1000000)
            return 1000000;
        if (n < 1000000000)
            return 1000000000;
        if (n < 1000000000000)
            return 1000000000000;
        if (n < 1000000000000000)
            return 1000000000000000;
        if (n < 1000000000000000000)
            return 1000000000000000000;
        return 1000000000000000000000;
    }

    Rectangle {
        id: mainCookie
        x: 0; y: 0;
        width: parent.width * 0.6
        height: parent.height
        color: parent.color
        Image {
            id: cookieImage
            source: "cookie.png"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width * 0.7 //sourceSize.width * 0.5
            height: parent.height * 0.6 //sourceSize.height * 0.5
        }

        Text {
            id: counterText
            property string cookieUnit: ""
            property string cookieString: cookies.toFixed(0) + cookieUnit + " cookies."
            text: cookieString
            anchors.right: cookieImage.right
            y: cookieImage.height + 95
            font.pointSize: 24
            font.family: fontRibeye.name
        }
        MouseArea {
            anchors.fill: cookieImage
            onClicked: {
                cookies += 1
            }
        }

        Text {
            id: text1
            x: 0
            y: 573
            width: 194
            height: 27
            text: qsTr(bps + " cookies per second")
            font.bold: true
            font.pointSize: 12
            font.pixelSize: 12
        }
    }

    ListModel {
        id: factoryModel
        ListElement {
            itemNumber: 1
            cout: 100
            name: "Crappy Factory"
            colorCode: "grey"
        }

        ListElement {
            itemNumber: 2
            cout: 500
            name: "Cheap Factory"
            colorCode: "grey"
        }

        ListElement {
            itemNumber: 3
            cout: 1000
            name: "Factory"
            colorCode: "grey"
        }

        ListElement {
            cout: 5000
            itemNumber: 4
            name: "Good Factory"
            colorCode: "grey"
        }

        ListElement {
            cout: 15000
            itemNumber: 5
            name: "Nice Factory"
            colorCode: "grey"
        }

        ListElement {
            cout: 75000
            itemNumber: 6
            name: "High-Tech Factory"
            colorCode: "grey"
        }

        ListElement {
            cout: 1000000
            itemNumber: 7
            name: "Futuristic Factory"
            colorCode: "grey"
        }

        ListElement {
            cout: 5000000
            itemNumber: 8
            name: "Science-Fiction Factory"
            colorCode: "grey"
        }


        ListElement {
            cout: 100000000
            itemNumber: 9
            name: "1337 Factory"
            colorCode: "grey"
        }

        ListElement {
            cout: 500000000
            itemNumber: 10
            name: "Crappy Mine"
            colorCode: "blue"
        }

        ListElement {
            cout: 7500000000
            itemNumber: 11
            name: "Cheap Mine"
            colorCode: "blue"
        }

        ListElement {
            cout: 100000000000
            itemNumber: 12
            name: "Mine"
            colorCode: "blue"
        }

        ListElement {
            cout: 7500000000000
            itemNumber: 13
            name: "Good Mine"
            colorCode: "blue"
        }

        ListElement {
            cout: 500000000000000
            itemNumber: 14
            name: "Nice Mine"
            colorCode: "blue"
        }

        ListElement {
            cout: 31337000000000000
            itemNumber: 15
            name: "High-Tech Mine"
            colorCode: "blue"
        }

        ListElement {
            cout: 75000000000000000000
            itemNumber: 16
            name: "Futuristic Mine"
            colorCode: "blue"

        }

        ListElement {
            cout: 1000000000000000000000
            itemNumber: 17
            name: "Science-Fiction Mine"
            colorCode: "blue"
        }

        ListElement {
            cout: 75000000000000000000000
            itemNumber: 18
            name: "1337 Mine"
            colorCode: "blue"
        }

    }

    Component {
        id: factoryDelegate
        Rectangle {
            height: delegateText.height * 1.5
            width: parent.width
            color: colorCode
            Text {
                id: delegateText
                text: name + " (" + cout + " cookies)"
                font.bold: true
                anchors.verticalCenter: parent.verticalCenter
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (cookies >= cout) {
                        selectedItemNumber = itemNumber;
                        cookies = cookies - cout
                        bps = bps + cout / 100
                        counterText.cookieString = cookies / getDiv(n) + getUnit(bps)
                    }
                    console.log("clicked " + selectedItemNumber)
                }
            }
        }
    }

    ListView {
        id: listView1
        anchors.left: mainCookie.right
        y: 0
        width: parent.width * 0.3
        height: parent.height
        model: factoryModel
        delegate: factoryDelegate
    }

    Timer {
        interval: 10; running: true; repeat: true;
        onTriggered: {
            cookies += bps / 100;
        }
    }
    Rectangle  {
        id: container
        property string text: "Reset"
        signal clicked
        x: 0
        y: 0
        width: buttonLabel.width + 20; height: buttonLabel.height + 5
        border  { width: 1; color: Qt.darker("blue") }
        smooth: true
        radius: 8

        MouseArea  {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                cookies = 100
                bps = 0
            }
        }

        Text  {
            id: buttonLabel
            anchors.centerIn: container
            color: "blue"
            text: container.text
        }
    }
}
