# TODO

## 🔧 In Progress

**Refactoring game architecture:**
- ✅ Centralized day advancement in `process_turn()`
- ✅ Moved day increment into `daily_updates()` (single place)
- 🚧 Moving game logic out of property setters
- 🚧 Adding state machine (PLAYER_TURN vs AWAITING_INPUT)
- 🚧 Splitting event checks (daily events vs game over conditions)

## 📋 Next Features

1. Escape progress (HUSTLE builds 0-100%, enables alternate victory)
2. Post-ship choice screen (ACCEPT TASK vs HUSTLE)
3. Random event when beg for mercy
4. Need indicator for time bombs?

## ✅ Completed

1. ✅ Payday system (payment every 5 days)
2. ✅ Task difficulty scaling by job level
3. ✅ Completed tasks counter
4. ✅ End game stats and structured endings
5. ✅ Overdue firing (3 days overdue = fired)
