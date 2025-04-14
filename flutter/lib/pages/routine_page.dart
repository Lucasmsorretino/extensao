import 'package:flutter/material.dart';

class RoutinePage extends StatefulWidget {
  @override
  _RoutinePageState createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  final _formKey = GlobalKey<FormState>();

  Map<String, String> meals = {
    'Lanche da Manhã': 'bem',
    'Almoço': 'bem',
    'Lanche da Tarde': 'bem',
    'Jantar': 'bem',
  };

  int evacuations = 0;
  String evacuationType = 'Normal';
  TimeOfDay? sleepStart;
  TimeOfDay? sleepEnd;
  List<Map<String, String>> medications = [];
  final TextEditingController _medTimeController = TextEditingController();
  final TextEditingController _medDosageController = TextEditingController();
  final TextEditingController _medAdminController = TextEditingController();
  final TextEditingController _observationController = TextEditingController();


  Future<void> _selectTime(BuildContext context, Function(TimeOfDay) onSelected) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) onSelected(picked);
  }

  void _addMedication() {
    setState(() {
      medications.add({
        'time': _medTimeController.text,
        'dosage': _medDosageController.text,
        'administered_by': _medAdminController.text,
      });
      _medTimeController.clear();
      _medDosageController.clear();
      _medAdminController.clear();
    });
  }

  Widget _buildDropdown(String label, String value, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        DropdownButtonFormField<String>(
          value: value,
          items: ['bem', 'pouco', 'recusou']
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Rotina')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Refeições:', style: TextStyle(fontWeight: FontWeight.bold)),
              ...meals.keys.map((meal) => _buildDropdown(meal, meals[meal]!, (val) => setState(() => meals[meal] = val!))),
              SizedBox(height: 16),
              Text('Evacuações:'),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: '0',
                      decoration: InputDecoration(labelText: 'Quantidade'),
                      onChanged: (val) => evacuations = int.tryParse(val) ?? 0,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: evacuationType,
                      items: ['Normal', 'Amolecida', 'Obstipado / Não evacuou']
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) => setState(() => evacuationType = val!),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              Text('Horário de Sono:'),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _selectTime(context, (val) => setState(() => sleepStart = val)),
                      child: Text(sleepStart == null ? 'Início' : 'Início: ${sleepStart!.format(context)}'),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _selectTime(context, (val) => setState(() => sleepEnd = val)),
                      child: Text(sleepEnd == null ? 'Fim' : 'Fim: ${sleepEnd!.format(context)}'),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              Text('Medicações:'),
              TextFormField(controller: _medTimeController, decoration: InputDecoration(labelText: 'Horário')),
              TextFormField(controller: _medDosageController, decoration: InputDecoration(labelText: 'Dosagem')),
              TextFormField(controller: _medAdminController, decoration: InputDecoration(labelText: 'Responsável')),
              ElevatedButton(onPressed: _addMedication, child: Text('Adicionar Medicação')),
              Column(
                children: medications.map((med) => ListTile(
                  title: Text('Horário: ${med['time']} - ${med['dosage']}'),
                  subtitle: Text('Responsável: ${med['administered_by']}'),
                )).toList(),
              ),
              SizedBox(height: 16),
              Text('Observações:'),
              TextFormField(
                controller: _observationController,
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Texto livre (opcional)',
                ),
              ),
              SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Enviar os dados
                    }
                  },
                  child: Text('Salvar Rotina'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
