import 'package:defaultflutterapp/keys.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  test('check flutter driver health', () async {
    final health = await driver.checkHealth();
    expect(health.status, HealthStatus.ok);
  });

  test('Increase counter', () async {
    final counterButton = find.byValueKey(Keys.counterButton);
    final counterDisplay = find.byValueKey(Keys.counterDisplay);

    await driver.tap(counterButton);
    final firstnumber = await driver.getText(counterDisplay);

    expect(int.parse(firstnumber), 1);

    await driver.tap(counterButton);
    await driver.tap(counterButton);
    final secondnumber = await driver.getText(counterDisplay);

    expect(int.parse(secondnumber), 3);
  });
}
