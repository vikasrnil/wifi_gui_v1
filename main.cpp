#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "wifi.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    WifiHandler wifi;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("wifi", &wifi);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
