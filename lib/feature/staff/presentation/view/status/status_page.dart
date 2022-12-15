import 'package:dut_packing_utility/base/presentation/base_app_bar.dart';
import 'package:dut_packing_utility/base/presentation/base_widget.dart';
import 'package:dut_packing_utility/base/presentation/widgets/common.dart';
import 'package:dut_packing_utility/utils/config/app_text_style.dart';
import 'package:dut_packing_utility/utils/gen/colors.gen.dart';
import '../../controller/status/status_controller.dart';

class StatusPage extends BaseWidget<StatusController> {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: const Text('Tình trạng nhà xe'),
      ),
      body: Obx(
        () => Stack(
          children: [
            Positioned.fill(
                child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.motorcycle_outlined,
                        size: 35,
                        color: ColorName.black000,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Số lượng phương tiện hiện tại:",
                        style: AppTextStyle.w600s19(ColorName.black000),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        controller.historys.length.toString(),
                        overflow: TextOverflow.clip,
                        style: AppTextStyle.w800s33(ColorName.black000),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.historys.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 0.5, color: ColorName.grayBdb),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 16),
                                const Icon(
                                  Icons.history_outlined,
                                  color: ColorName.primaryColor,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Thời gian đi vào:",
                                  style: AppTextStyle.w600s16(ColorName.black000),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  (controller.historys[index].dateOfCheckIn ?? DateTime(2022)).toIso8601String(),
                                  overflow: TextOverflow.clip,
                                  style: AppTextStyle.w500s15(ColorName.black000),
                                ),
                                const SizedBox(width: 16),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: [
                                const SizedBox(width: 16),
                                const Icon(
                                  Icons.security_outlined,
                                  color: ColorName.primaryColor,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Biển số xe:",
                                  style: AppTextStyle.w600s16(ColorName.black000),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  controller.historys[index].vehicalLicensePlate ?? "",
                                  overflow: TextOverflow.clip,
                                  style: AppTextStyle.w500s15(ColorName.black000),
                                ),
                                const SizedBox(width: 16),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: [
                                const SizedBox(width: 16),
                                const Icon(
                                  Icons.description,
                                  color: ColorName.primaryColor,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Mô tả:",
                                  style: AppTextStyle.w600s16(ColorName.black000),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  controller.historys[index].vehicalDescription ?? "",
                                  overflow: TextOverflow.clip,
                                  style: AppTextStyle.w500s15(ColorName.black000),
                                ),
                                const SizedBox(width: 16),
                              ],
                            ),
                            const SizedBox(width: 8),
                            const SizedBox(width: 8),
                            Row(
                              children: [
                                const SizedBox(width: 16),
                                const Icon(
                                  Icons.person_pin,
                                  color: ColorName.primaryColor,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Tên khách hàng:",
                                  style: AppTextStyle.w600s16(ColorName.black000),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  controller.historys[index].customerName ?? "",
                                  overflow: TextOverflow.clip,
                                  style: AppTextStyle.w500s15(ColorName.black000),
                                ),
                                const SizedBox(width: 16),
                              ],
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
            if (controller.loadPageState.value)
              Positioned.fill(
                child: Container(
                  color: ColorName.black000.withOpacity(0.6),
                  child: const LoadingWidget(
                    color: ColorName.whiteFff,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
