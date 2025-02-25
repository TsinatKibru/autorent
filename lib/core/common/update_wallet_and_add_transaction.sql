CREATE OR REPLACE FUNCTION update_wallet_and_add_transaction(
  profile_id UUID,
  new_balance NUMERIC,
  transaction_type TEXT,
  transaction_amount NUMERIC
) RETURNS VOID AS $$
DECLARE
  wallet_id INTEGER;
BEGIN
  -- Fetch the wallet_id for the given profile_id
  SELECT id INTO wallet_id
  FROM wallets
  WHERE profile = profile_id;

  -- Check if a wallet was found
  IF NOT FOUND THEN
    RAISE EXCEPTION 'No wallet found for profile_id: %', profile_id;
  END IF;

  -- Update the wallet balance
  UPDATE wallets
  SET balance = new_balance
  WHERE id = wallet_id;

  -- Insert a new transaction
  INSERT INTO transactions (wallet_id, type, amount)
  VALUES (wallet_id, transaction_type, transaction_amount);
END;
$$ LANGUAGE plpgsql;