import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0

import org.kde.latte.components 1.0 as LatteComponents

ColumnLayout {
    Layout.fillWidth: true
        
    LatteComponents.SubHeader {
        text: i18n("Line Indicator")
    }
        
    ColumnLayout {
        spacing: 0

        LatteComponents.CheckBox {
            Layout.maximumWidth: dialog.optionsWidth
            text: i18n("Show line indicator")
            checked: indicator.configuration.lineVisible

            onClicked: {
                indicator.configuration.lineVisible = !indicator.configuration.lineVisible;
            }
        }

        LatteComponents.CheckBox {
            Layout.maximumWidth: dialog.optionsWidth
            text: i18n("Reverse indicator position")
            checked: indicator.configuration.reversed
            visible: indicator.configuration.lineVisible

            onClicked: {
                indicator.configuration.reversed = !indicator.configuration.reversed;
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 2
            visible: indicator.configuration.lineVisible

            PlasmaComponents.Label {
                Layout.minimumWidth: implicitWidth
                horizontalAlignment: Text.AlignLeft
                Layout.rightMargin: units.smallSpacing
                text: i18n("Line Thickness")
            }

            LatteComponents.Slider {
                id: lineSlider
                Layout.fillWidth: true

                leftPadding: 0
                value: indicator.configuration.lineThickness * 100
                from: 2
                to: 20
                stepSize: 1
                wheelEnabled: false

                function updateLineThickness() {
                    if (!pressed) {
                        indicator.configuration.lineThickness = value/100;
                    }
                }

                onPressedChanged: {
                    updateLineThickness();
                }

                Component.onCompleted: {
                    valueChanged.connect(updateLineThickness);
                }

                Component.onDestruction: {
                    valueChanged.disconnect(updateLineThickness);
                }
            }

            PlasmaComponents.Label {
                text: i18nc("number in percentage, e.g. 85 %","%1 %", lineSlider.value)
                horizontalAlignment: Text.AlignRight
                Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 4
                Layout.maximumWidth: theme.mSize(theme.defaultFont).width * 4
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 2
            visible: indicator.configuration.lineVisible

            PlasmaComponents.Label {
                Layout.minimumWidth: implicitWidth
                horizontalAlignment: Text.AlignLeft
                Layout.rightMargin: units.smallSpacing
                text: i18n("Line Radius")
            }

            LatteComponents.Slider {
                id: lineRadSlider
                Layout.fillWidth: true

                leftPadding: 0
                value: indicator.configuration.lineRadius
                from: 0
                to: 15
                stepSize: 1
                wheelEnabled: false

                function updateLineRadius() {
                    if (!pressed) {
                        indicator.configuration.lineRadius = value;
                    }
                }

                onPressedChanged: {
                    updateLineRadius();
                }

                Component.onCompleted: {
                    valueChanged.connect(updateLineRadius);
                }

                Component.onDestruction: {
                    valueChanged.disconnect(updateLineRadius);
                }
            }

            PlasmaComponents.Label {
                text: i18nc("number with no decimals","%1", lineRadSlider.value)
                horizontalAlignment: Text.AlignRight
                Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 4
                Layout.maximumWidth: theme.mSize(theme.defaultFont).width * 4
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 2
            visible: indicator.configuration.lineVisible

            LatteComponents.CheckBox {
                Layout.maximumWidth: dialog.optionsWidth
                text: i18n("Custom active color")
                checked: indicator.configuration.customLineActiveColor

                onClicked: {
                    indicator.configuration.customLineActiveColor = !indicator.configuration.customLineActiveColor
                }
            }

            PlasmaComponents.Button {
                id: lineActiveColorPickBtn
                Layout.minimumWidth: implicitWidth
                Layout.maximumWidth: Layout.minimumWidth
                visible: indicator.configuration.customLineActiveColor
                checked: false
                checkable: false
                ToolTip.text: i18n("Active color for the line indicator")
                ToolTip.visible: hovered
                ToolTip.delay: 1000
                icon.name: "color-picker"

                ColorDialog {
                    id: lineActiveColorDialog

                    title: "Color of active line indicator"
                    color: indicator.configuration.lineActiveColor
                    onAccepted: {
                        indicator.configuration.lineActiveColor = lineActiveColorDialog.color
                    }
                }

                onPressedChanged: {
                    if (pressed) {
                        lineActiveColorDialog.open()
                    }
                }
            }

            Rectangle {
                visible: indicator.configuration.customLineActiveColor
                width: lineActiveColorPickBtn.width
                height: lineActiveColorPickBtn.height
                radius: 5
                color: indicator.configuration.lineActiveColor
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 2
            visible: indicator.configuration.lineVisible

            LatteComponents.CheckBox {
                Layout.maximumWidth: dialog.optionsWidth
                text: i18n("Custom inactive color")
                checked: indicator.configuration.customLineInactiveColor

                onClicked: {
                    indicator.configuration.customLineInactiveColor = !indicator.configuration.customLineInactiveColor
                }
            }

            PlasmaComponents.Button {
                id: lineInactiveColorPickBtn
                Layout.minimumWidth: implicitWidth
                Layout.maximumWidth: Layout.minimumWidth
                visible: indicator.configuration.customLineInactiveColor
                checked: false
                checkable: false
                ToolTip.text: i18n("Inactive color for the line indicator")
                ToolTip.visible: hovered
                ToolTip.delay: 1000
                icon.name: "color-picker"

                ColorDialog {
                    id: lineInactiveColorDialog

                    title: "Color of inactive line indicator"
                    color: indicator.configuration.lineInactiveColor
                    onAccepted: {
                        indicator.configuration.lineInactiveColor = lineInactiveColorDialog.color
                    }
                }

                onPressedChanged: {
                    if (pressed) {
                        lineInactiveColorDialog.open()
                    }
                }
            }

            Rectangle {
                visible: indicator.configuration.customLineInactiveColor
                width: lineInactiveColorPickBtn.width
                height: lineInactiveColorPickBtn.height
                radius: 5
                color: indicator.configuration.lineInactiveColor
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 2
            visible: indicator.configuration.lineVisible

            LatteComponents.CheckBox {
                Layout.maximumWidth: dialog.optionsWidth
                text: i18n("Custom attention color")
                checked: indicator.configuration.customLineAttentionColor

                onClicked: {
                    indicator.configuration.customLineAttentionColor = !indicator.configuration.customLineAttentionColor
                }
            }

            PlasmaComponents.Button {
                id: lineAttentionColorPickBtn
                Layout.minimumWidth: implicitWidth
                Layout.maximumWidth: Layout.minimumWidth
                visible: indicator.configuration.customLineAttentionColor
                checked: false
                checkable: false
                ToolTip.text: i18n("Attention color for the line indicator")
                ToolTip.visible: hovered
                ToolTip.delay: 1000
                icon.name: "color-picker"

                ColorDialog {
                    id: lineAttentionColorDialog

                    title: "Color of attention line indicator"
                    color: indicator.configuration.lineAttentionColor
                    onAccepted: {
                        indicator.configuration.lineAttentionColor = lineAttentionColorDialog.color
                    }
                }

                onPressedChanged: {
                    if (pressed) {
                        lineAttentionColorDialog.open()
                    }
                }
            }

            Rectangle {
                visible: indicator.configuration.customLineAttentionColor
                width: lineAttentionColorPickBtn.width
                height: lineAttentionColorPickBtn.height
                radius: 5
                color: indicator.configuration.lineAttentionColor
            }
        }
    }

    LatteComponents.SubHeader {
        text: i18n("Misc Options")
    }

    RowLayout {
        Layout.fillWidth: true
        spacing: units.smallSpacing

        PlasmaComponents.Label {
            Layout.minimumWidth: implicitWidth
            horizontalAlignment: Text.AlignLeft
            Layout.rightMargin: units.smallSpacing
            text: i18n("Animation Speed")
        }

        LatteComponents.Slider {
            id: animSpeedSlider
            Layout.fillWidth: true

            leftPadding: 0
            value: indicator.configuration.animationSpeed * 100
            from: 10
            to: 200
            stepSize: 5
            wheelEnabled: false

            function updateAnimSpeed() {
                if (!pressed) {
                    indicator.configuration.animationSpeed = value/100;
                }
            }

            onPressedChanged: {
                updateAnimSpeed();
            }

            Component.onCompleted: {
                valueChanged.connect(updateAnimSpeed);
            }

            Component.onDestruction: {
                valueChanged.disconnect(updateAnimSpeed);
            }
        }

        PlasmaComponents.Label {
            text: i18nc("number in percentage, e.g. 85 %","%1 %", animSpeedSlider.value)
            horizontalAlignment: Text.AlignRight
            Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 4
            Layout.maximumWidth: theme.mSize(theme.defaultFont).width * 4
        }
    }

    RowLayout {
        Layout.fillWidth: true
        spacing: units.smallSpacing
        visible: deprecatedPropertiesAreHidden

        PlasmaComponents.Label {
            text: i18n("Tasks Length")
            horizontalAlignment: Text.AlignLeft
        }

        LatteComponents.Slider {
            id: lengthIntMarginSlider
            Layout.fillWidth: true

            value: Math.round(indicator.configuration.lengthPadding * 100)
            from: 5
            to: maxMargin
            stepSize: 1
            wheelEnabled: false

            readonly property int maxMargin: 80

            onPressedChanged: {
                if (!pressed) {
                    indicator.configuration.lengthPadding = value / 100;
                }
            }
        }

        PlasmaComponents.Label {
            text: i18nc("number in percentage, e.g. 85 %","%1 %", currentValue)
            horizontalAlignment: Text.AlignRight
            Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 4
            Layout.maximumWidth: theme.mSize(theme.defaultFont).width * 4

            readonly property int currentValue: lengthIntMarginSlider.value
        }
    }

    RowLayout {
        Layout.fillWidth: true
        spacing: 2

        PlasmaComponents.Label {
            Layout.minimumWidth: implicitWidth
            horizontalAlignment: Text.AlignLeft
            Layout.rightMargin: units.smallSpacing
            text: i18n("Applets Length")
        }

        LatteComponents.Slider {
            id: appletPaddingSlider
            Layout.fillWidth: true

            leftPadding: 0
            value: indicator.configuration.appletPadding * 100
            from: 0
            to: 80
            stepSize: 5
            wheelEnabled: false

            function updateMargin() {
                if (!pressed) {
                    indicator.configuration.appletPadding = value/100;
                }
            }

            onPressedChanged: {
                updateMargin();
            }

            Component.onCompleted: {
                valueChanged.connect(updateMargin);
            }

            Component.onDestruction: {
                valueChanged.disconnect(updateMargin);
            }
        }

        PlasmaComponents.Label {
            text: i18nc("number in percentage, e.g. 85 %","%1 %", appletPaddingSlider.value)
            horizontalAlignment: Text.AlignRight
            Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 4
            Layout.maximumWidth: theme.mSize(theme.defaultFont).width * 4
        }
    }

    LatteComponents.CheckBoxesColumn {
        Layout.fillWidth: true

        LatteComponents.CheckBox {
            Layout.maximumWidth: dialog.optionsWidth
            text: i18n("Progress animation in background")
            checked: indicator.configuration.progressAnimationEnabled

            onClicked: {
                indicator.configuration.progressAnimationEnabled = !indicator.configuration.progressAnimationEnabled
            }
        }
    }

    LatteComponents.CheckBox {
        Layout.maximumWidth: dialog.optionsWidth
        text: i18n("Show indicators for applets")
        checked: indicator.configuration.enabledForApplets
        tooltip: i18n("Indicators are shown for applets")
        visible: deprecatedPropertiesAreHidden

        onClicked: {
            indicator.configuration.enabledForApplets = !indicator.configuration.enabledForApplets;
        }
    }
}
