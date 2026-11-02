import QtQuick
import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid

PlasmoidItem {
    id: root

    Plasmoid.icon: "com.rafaelmardojai.Blanket-symbolic"
    Plasmoid.status: blanket.running ? PlasmaCore.Types.ActiveStatus : PlasmaCore.Types.HiddenStatus
    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground

    property var configurationAction: null
    property bool configurationEnabled: false

    Plasmoid.contextualActions: [
        PlasmaCore.Action {
            text: root.configurationAction ? root.configurationAction.text : i18n("Configure…")
            icon.name: "configure"
            visible: root.configurationAction !== null
            enabled: root.configurationEnabled
            onTriggered: root.configurationAction.trigger()
        },
        PlasmaCore.Action {
            isSeparator: true
            visible: root.configurationAction !== null
        },
        PlasmaCore.Action {
            text: i18n("Quit Blanket")
            icon.name: "application-exit"
            enabled: blanket.running
            onTriggered: blanket.quit()
        }
    ]

    toolTipMainText: i18n("Blanket")
    toolTipSubText: i18n("Open Blanket")
    preferredRepresentation: compactRepresentation
    fullRepresentation: compactRepresentation

    BlanketController {
        id: blanket
    }

    activationTogglesExpanded: false

    Connections {
        target: Plasmoid

        function onContextualActionsAboutToShow() {
            root.configurationAction = Plasmoid.internalAction("configure");
            if (root.configurationAction && root.configurationAction.visible) {
                root.configurationEnabled = root.configurationAction.enabled;
                // Plasma appends its settings action last. Use the proxy above
                // instead so Quit stays in a separate section at the bottom.
                root.configurationAction.visible = false;
            }
        }

        function onActivated() {
            blanket.open();
        }
    }

    compactRepresentation: MouseArea {
        implicitWidth: Kirigami.Units.iconSizes.medium
        implicitHeight: Kirigami.Units.iconSizes.medium
        acceptedButtons: Qt.LeftButton
        hoverEnabled: true
        onClicked: blanket.open()

        Kirigami.Icon {
            anchors.fill: parent
            source: root.Plasmoid.icon
            isMask: true
            color: Kirigami.Theme.textColor
            active: parent.containsMouse
        }
    }
}
