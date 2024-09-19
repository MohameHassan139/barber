import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/add_service_cubit/cubit/add_service_cubit.dart';

class AddServiceScreen extends StatelessWidget {
  const AddServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddServiceCubit>(
      create: (context) => AddServiceCubit(),
      child: Scaffold(
        body: Center(
          child: BlocBuilder<AddServiceCubit, AddServiceState>(
            builder: (context, state) {
              return TextButton(
                onPressed: () {
                  var cubit = context.read<AddServiceCubit>();
                  cubit.addService(
                    cost: 100,
                    name: 'test',
                    time: 10,
                    description: 'test',
                    imageUrl: 'test',
                  );
                },
                child: const Text('Add Service'),
              );
            },
          ),
        ),
      ),
    );
  }
}
