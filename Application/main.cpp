#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>
#include "ordermodel.h"
#include "customerordermodel.h"
#include"employeeordermodel.h"
#include "serviceaccessor.h"
#include <QDebug>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QQuickStyle::setStyle("Material");
    QGuiApplication app(argc, argv);

    OrderModel::registerMe("Orders");
    CustomerOrderModel::registerMe("CustomerOrders");
    EmployeeOrderModel::registerMe("EmployeeOrders");


    serviceaccessor *serviceAccessor = new serviceaccessor();


    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("serviceAccessor",serviceAccessor);

    engine.addImportPath(":/qml");
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
