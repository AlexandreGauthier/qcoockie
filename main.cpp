#include <QtGui/QGuiApplication>
#include <QtQml>
#include "qtquick2applicationviewer.h"

#include "fileio.h"
#include "setting.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<FileIO, 1>("FileIO", 1, 0, "FileIO");
    Settings settings("CookieClicker", "desert.score2");

    QtQuick2ApplicationViewer viewer;
    viewer.rootContext()->setContextProperty("settings", &settings);
    viewer.setMainQmlFile(QStringLiteral("qml/superapp/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
