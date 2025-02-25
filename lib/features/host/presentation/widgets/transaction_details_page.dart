import 'package:car_rent/core/common/bloc/transation/transaction_bloc.dart';
import 'package:car_rent/core/common/constants.dart';
import 'package:car_rent/core/common/entities/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

class TransactionDetailsPage extends StatefulWidget {
  final int walletId;

  const TransactionDetailsPage({Key? key, required this.walletId})
      : super(key: key);

  @override
  _TransactionDetailsPageState createState() => _TransactionDetailsPageState();
}

class _TransactionDetailsPageState extends State<TransactionDetailsPage> {
  String _filterType = 'All';
  DateTime? _startDate;
  DateTime? _endDate;
  final List<String> _filterOptions = ['All', 'Income', 'Debit'];
  final PanelController _panelController = PanelController();

  @override
  void initState() {
    super.initState();
    context
        .read<TransactionBloc>()
        .add(GetTransactionsByWalletIdEvent(widget.walletId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.green],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        child: const Icon(Icons.filter_list, color: Colors.white),
        onPressed: () => _panelController.isPanelOpen
            ? _panelController.close()
            : _panelController.open(),
      ),
      body: SlidingUpPanel(
        controller: _panelController,
        panel: _buildFilterPanel(),
        minHeight: 0,
        maxHeight: 250,
        borderRadius: BorderRadius.circular(20),
        body: _buildTransactionList(),
      ),
    );
  }

  Widget _buildTransactionList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TransactionLoadSuccess) {
            final transactions = _filterTransactions(state.transactions);
            final totalAmount = _calculateTotalAmount(transactions);

            return Column(
              children: [
                _buildTotalAmountCard(totalAmount),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      return _buildTransactionCard(transactions[index]);
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No transactions found.'));
          }
        },
      ),
    );
  }

  Widget _buildFilterPanel() {
    return Column(
      children: [
        const SizedBox(height: 10),
        SizedBox(
          width: 300,
          child: _buildFilterDropdown(),
        ),
        const SizedBox(height: 10),
        _buildDateRangePicker(),
      ],
    );
  }

  Widget _buildFilterDropdown() {
    return DropdownButtonFormField<String>(
      value: _filterType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onChanged: (newValue) {
        setState(() {
          _filterType = newValue!;
        });
      },
      items: _filterOptions.map((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value, style: const TextStyle(fontSize: 16)),
        );
      }).toList(),
    );
  }

  Widget _buildDateRangePicker() {
    return OutlinedButton.icon(
      onPressed: () async {
        DateTimeRange? picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
          initialDateRange: _startDate != null && _endDate != null
              ? DateTimeRange(start: _startDate!, end: _endDate!)
              : null,
        );
        if (picked != null) {
          setState(() {
            _startDate = picked.start;
            _endDate = picked.end;
          });
        }
      },
      icon: const Icon(Icons.calendar_today, size: 20),
      label: Text(
        _startDate == null || _endDate == null
            ? 'Select Date Range'
            : '${_formatDate(_startDate!)} - ${_formatDate(_endDate!)}',
        style: const TextStyle(fontSize: 16),
      ),
      // label: const Text('Select Date Range', style: TextStyle(fontSize: 16)),
    );
  }

  Widget _buildTotalAmountCard(double totalAmount) {
    return _ToggleableCard(
      additionalContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Text('Amount Gained', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          Text(
            '\$${(totalAmount / Constants.commisionrate).toStringAsFixed(2)}', // Gained amount = totalAmount * 10
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.green[700], // Green color for gained amount
            ),
          ),
        ],
      ),
      totalcard: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Total Amount', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          Text(
            '\$${totalAmount.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(Transaction transaction) {
    return _ToggleableCard(
      additionalContent: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          'Gained: \$${(transaction.amount / Constants.commisionrate).toStringAsFixed(2)}', // Gained amount = amount * 10
          style: TextStyle(
            fontSize: 16,
            color: Colors.green[700], // Green color for gained amount
          ),
        ),
      ),
      totalcard: false,
      child: ListTile(
        leading: Icon(
          transaction.type.toLowerCase() == 'income'
              ? Icons.arrow_upward
              : Icons.arrow_downward,
          color: transaction.type.toLowerCase() == 'income'
              ? Colors.green
              : Colors.red,
        ),
        title: Text(
          transaction.type,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '\$${transaction.amount.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        trailing: Text(
          _formatDate(transaction.timestamp),
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ),
    );
  }

  List<Transaction> _filterTransactions(List<Transaction> transactions) {
    return transactions.where((transaction) {
      bool typeMatches = _filterType == 'All' ||
          transaction.type.toLowerCase() == _filterType.toLowerCase();
      bool dateMatches = (_startDate == null || _endDate == null) ||
          (transaction.timestamp.isAfter(_startDate!) &&
              transaction.timestamp.isBefore(_endDate!));
      return typeMatches && dateMatches;
    }).toList(); // ✅ Always returns a List<Transaction>, never null
  }

  double _calculateTotalAmount(List<Transaction> transactions) {
    return transactions.fold(0.0, (sum, transaction) {
      return transaction.type.toLowerCase() == 'debit'
          ? sum +
              (transaction.amount / Constants.commisionrate -
                  transaction.amount)
          : sum + transaction.amount;
    }); // ✅ Always returns a double
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A'; // ✅ Handle null case
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _ToggleableCard extends StatefulWidget {
  final Widget child;
  final Widget additionalContent;
  final bool totalcard;

  const _ToggleableCard(
      {required this.child,
      required this.additionalContent,
      required this.totalcard});

  @override
  __ToggleableCardState createState() => __ToggleableCardState();
}

class __ToggleableCardState extends State<_ToggleableCard> {
  bool _showAdditionalContent = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation:
          _showAdditionalContent ? 4 : 2, // Slightly elevate when expanded
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          setState(() {
            _showAdditionalContent =
                !_showAdditionalContent; // Toggle visibility
          });
        },
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: widget.totalcard
              ? const EdgeInsets.all(16.0)
              : const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.child,
              if (_showAdditionalContent) widget.additionalContent,
            ],
          ),
        ),
      ),
    );
  }
}
